module Pageflow
  module Panorama
    module Validation
      class Error < StandardError
        attr_reader :message_i18n_key

        def initialize(message_i18n_key)
          super("Archive is not valid: #{message_i18n_key}")
          @message_i18n_key = message_i18n_key
        end
      end
    end
  end
end
