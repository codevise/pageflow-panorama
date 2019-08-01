require 'spec_helper'
require 'pageflow/used_file_test_helper'

module Pageflow
  module Panorama
    describe PackagesHelper do
      include UsedFileTestHelper

      describe '#panorama_url' do
        context 'URL panorama source' do
          it 'should return specified panorama url when panorama source is URL' do
            @entry = PublishedEntry.new(create(:entry, :published))
            configuration = {
              'panorama_source' => 'url',
              'panorama_url' => 'S3-url'
            }

            url = helper.panorama_url(configuration)
            expect(url).to eq('S3-url')
          end
        end

        it 'should return nil if no package can be found' do
          @entry = PublishedEntry.new(create(:entry, :published))
          configuration = {
            'panorama_package_id' => 500
          }

          expect(helper.panorama_url(configuration)).to be_nil
        end

        it 'should return the packages index document path' do
          panorama_package_file = create_used_file(:package)
          configuration = {
            'panorama_package_id' => panorama_package_file.perma_id
          }

          url = helper.panorama_url(configuration)
          expect(url).to match(/#{panorama_package_file.id}\/unpacked\/#{panorama_package_file.perma_id}/)
        end
      end
    end
  end
end
