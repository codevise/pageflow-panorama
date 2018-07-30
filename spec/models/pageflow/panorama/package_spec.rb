require 'spec_helper'

module Pageflow
  module Panorama
    describe Package do
      describe '#process', perform_jobs: true do
        it 'parses thumbnail and index document' do
          zip_file = File.open(Engine.root.join('spec', 'fixtures', 'krpano.zip'))
          package = Package.create!(attachment: zip_file)

          package.publish!
          package.reload

          expect(package.thumbnail).to be_present
          expect(package.index_document).to be_present
        end

        it 'uploads files to bucket' do
          zip_file = File.open(Engine.root.join('spec', 'fixtures', 'krpano.zip'))
          package = Package.create!(attachment: zip_file)
          bucket = Doubles.bucket

          Panorama.bucket_factory = TestBucketFactory.new(bucket)

          package.publish!
          package.reload

          expect(bucket).to have_received(:write)
            .with(hash_including(name: package.index_document_path))
        end

        it 'updates unpacking_progress' do
          zip_file = File.open(Engine.root.join('spec', 'fixtures', 'krpano.zip'))
          package = Package.create!(attachment: zip_file)

          package.publish!
          package.reload

          expect(package.unpacking_progress).to eq(100)
        end

        it 'transitions to failed state if validation fails' do
          zip_file = File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip'))
          package = Package.create!(attachment: zip_file)

          package.publish!
          package.reload

          expect(package.state).to eq('unpacking_failed')
        end

        it 'transitions to failed state if thumbnail is unprocessable' do
          zip_file = File.open(Engine.root.join('spec',
                                                'fixtures',
                                                'krpano_with_unprocessable_thumbnail.zip'))
          package = Package.create!(attachment: zip_file)

          package.publish!
          package.reload

          expect(package.state).to eq('unpacking_failed')
        end

        class TestBucketFactory
          def initialize(bucket)
            @bucket = bucket
          end

          def from_attachment(_attachment)
            @bucket
          end
        end
      end

      describe '#retry' do
        it 'resets unpacking progress and error_message' do
          zip_file = File.open(Engine.root.join('spec', 'fixtures', 'krpano.zip'))
          package = Package.create!(attachment: zip_file,
                                    state: 'unpacking_failed',
                                    unpacking_progress: 50,
                                    unpacking_error_message: 'failed')

          package.retry!

          expect(package.unpacking_progress).to eq(0)
          expect(package.unpacking_error_message).to eq(nil)
        end
      end
    end
  end
end
