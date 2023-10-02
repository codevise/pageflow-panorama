require 'rspec/mocks'

module Doubles
  extend RSpec::Mocks::ExampleMethods
  extend self

  def bucket
    instance_double(Pageflow::Panorama::S3Bucket).as_null_object
  end

  def bucket_raising_once(error)
    bucket.tap do |bucket|
      called = false

      allow(bucket).to receive(:write) do
        unless called
          called = true
          raise error
        end
      end
    end
  end

  def bucket_raising(error)
    bucket.tap do |bucket|
      allow(bucket).to receive(:write).and_raise(error)
    end
  end
end
