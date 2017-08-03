require 'spec_helper'

module Pageflow
  module Panorama
    describe UnpackToS3 do
      describe '#upload' do
        it 'writes files from zip to bucket' do
          archive = Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip'))
          bucket = Doubles.bucket
          unpack_to_s3 = UnpackToS3.new(archive: archive,
                                        destination_bucket: bucket,
                                        destination_base_path: 'base')

          unpack_to_s3.upload

          expect(bucket).to have_received(:write).with(hash_including(name: 'base/some.txt'))
        end

        it 'reports progress' do
          archive = Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip'))
          bucket = Doubles.bucket
          unpack_to_s3 = UnpackToS3.new(archive: archive,
                                        destination_bucket: bucket,
                                        destination_base_path: 'base')

          expect { |probe|
            unpack_to_s3.upload(&probe)
          }.to yielding_successive_args(0, 100)
        end

        it 'determines content type via mapping' do
          archive = Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip'))
          bucket = Doubles.bucket
          unpack_to_s3 = UnpackToS3.new(archive: archive,
                                        destination_bucket: bucket,
                                        destination_base_path: 'base',
                                        content_type_mapping: {
                                          'txt' => 'text/plain'
                                        })

          unpack_to_s3.upload

          expect(bucket).to have_received(:write).with(hash_including(content_type: 'text/plain'))
        end

        it 'retries when write fails' do
          archive = Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip'))
          bucket = Doubles.bucket_raising_once(AWS::S3::Errors::SlowDown)
          unpack_to_s3 = UnpackToS3.new(archive: archive,
                                        destination_bucket: bucket,
                                        destination_base_path: 'base')

          allow(unpack_to_s3).to receive(:sleep)
          unpack_to_s3.upload

          expect(bucket).to have_received(:write).twice
        end

        it 're-raises exception when write fails too often' do
          archive = Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip'))
          bucket = Doubles.bucket_raising(AWS::S3::Errors::SlowDown)
          unpack_to_s3 = UnpackToS3.new(archive: archive,
                                        destination_bucket: bucket,
                                        destination_base_path: 'base')

          allow(unpack_to_s3).to receive(:sleep)

          expect {
            unpack_to_s3.upload
          }.to raise_error(AWS::S3::Errors::SlowDown)
        end
      end
    end
  end
end
