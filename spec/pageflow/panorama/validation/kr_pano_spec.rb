require 'spec_helper'

module Pageflow
  module Panorama
    module Validation
      describe KrPano do
        def entry_double(name, type, size)
          double(name: name, size: size).tap do |entry|
            allow(entry).to receive(:file?).and_return(type == :file)
          end
        end

        let(:entries_of_valid_archive) do
          [
            entry_double('pano.tiles/', :directory, 0),
            entry_double('pano.tiles/mobile_f.jpg', :file, 40),
            entry_double('pano.html', :file, 60),
            entry_double('pano.xml', :file, 60)
          ]
        end

        let(:entries_of_archive_without_tiles) do
          [
            entry_double('pano.html', :file, 60),
            entry_double('pano.xml', :file, 60)
          ]
        end

        let(:entries_silly_macosx_archive) do
          [
            entry_double('__MACOSX/', :directory, 0),
            entry_double('__MACOSX/pano.tiles/', :directory, 0),
            entry_double('__MACOSX/pano.tiles/._mobile_f.jpg', :file, 40),
            entry_double('pano.tiles/', :directory, 0),
            entry_double('pano.tiles/mobile_f.jpg', :file, 40),
            entry_double('pano.html', :file, 60),
            entry_double('pano.xml', :file, 60)
          ]
        end

        describe '#parse' do
          it 'finds thumbnail' do
            validation = KrPano.new(entries_of_valid_archive)

            result = validation.parse

            expect(result.thumbnail).to eq('pano.tiles/mobile_f.jpg')
          end

          it 'ignores thumbnails starting with dot' do
            validation = KrPano.new(entries_silly_macosx_archive)

            result = validation.parse

            expect(result.thumbnail).to eq('pano.tiles/mobile_f.jpg')
          end

          it 'finds index document' do
            validation = KrPano.new(entries_of_valid_archive)

            result = validation.parse

            expect(result.index_document).to eq('pano.html')
          end

          it 'raises validation error if tiles dir is missing' do
            entries = entries_of_archive_without_tiles
            validation = KrPano.new(entries)

            expect {
              validation.parse
            }.to raise_error(Error)
          end
        end
      end
    end
  end
end
