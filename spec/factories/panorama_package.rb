module Pageflow
  module Panorama
    FactoryBot.define do
      factory :package, class: Package do
        attachment { File.open(Engine.root.join('spec', 'fixtures', 'some.txt.zip')) }
        index_document { true }
        state { 'unpacked' }
      end
    end
  end
end
