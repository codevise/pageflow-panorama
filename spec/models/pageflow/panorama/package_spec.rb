require 'spec_helper'

module Pageflow
  module Panorama
    describe Package, inline_resque: true do
      describe '#process' do
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

        class TestBucketFactory
          def initialize(bucket)
            @bucket = bucket
          end

          def from_attachment(_attachment)
            @bucket
          end
        end
      end
    end
  end
end
