RSpec.configure do |config|
  config.before(:each) do
    Pageflow::Panorama.bucket_factory = DoubleBucketFactory.new
  end

  class DoubleBucketFactory
    def from_attachment(_attachment)
      Doubles.bucket
    end
  end
end
