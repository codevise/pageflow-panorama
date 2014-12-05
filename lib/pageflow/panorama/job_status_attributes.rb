module Pageflow
  module Panorama
    class JobStatusAttributes < Struct.new(:record, :stage_name)
      def self.handle(record, options = {}, &block)
        new(record, options[:stage]).call(&block)
      end

      def call(&block)
        update_progress(0)

        with_error_message_handling do
          block.call do |percent|
            update_progress(percent)
          end
        end
      end

      private

      def update_progress(percent)
        record.update(stage_attribute_name(:progress) => percent,
                      stage_attribute_name(:error_message) => nil)
      end

      def with_error_message_handling
        yield
      rescue StandardError => e
        if e.respond_to?(:message_i18n_key)
          record[stage_attribute_name(:error_message)] = e.message_i18n_key
        end

        raise
      end

      def stage_attribute_name(suffix)
        [stage_name, suffix].compact.join('_')
      end
    end
  end
end
