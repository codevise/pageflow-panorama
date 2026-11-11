require 'spec_helper'

module Pageflow
  module Panorama
    describe ZipEntryPaperclipIOAdapter do
      it 'is used for zip entries' do
        Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip')) do |archive|
          adapter = Paperclip.io_adapters.for(archive.find_entry('some.txt'))

          expect(adapter).to be_a(ZipEntryPaperclipIOAdapter)
        end
      end

      it 'provides contents of entry' do
        Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip')) do |archive|
          adapter = Paperclip.io_adapters.for(archive.find_entry('some.txt'))

          expect(adapter.read).to eq("text\n")
        end
      end

      it 'provides file name and size of entry' do
        Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip')) do |archive|
          adapter = Paperclip.io_adapters.for(archive.find_entry('some.txt'))

          expect(adapter.original_filename).to eq('some.txt')
          expect(adapter.size).to eq(5)
        end
      end

      it 'detects content type of entry' do
        Zip::File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip')) do |archive|
          adapter = Paperclip.io_adapters.for(archive.find_entry('some.txt'))

          expect(adapter.content_type).to eq('text/plain')
        end
      end
    end
  end
end
