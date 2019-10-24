require 'spec_helper'
require 'pageflow/lint'

module Pageflow
  module Panorama
    Pageflow::Lint.file_type(:package,
                             create_file_type: -> { Panorama.package_file_type },
                             create_file: -> { create(:package) })
  end
end