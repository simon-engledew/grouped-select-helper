module ActionView
  module Helpers
    module FormOptionsHelper
      def grouped_select(object, method, choices, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_grouped_select_tag(choices, options, html_options)
      end
    end
    
    class InstanceTag
      def to_grouped_select_tag(choices, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        selected_value = options.has_key?(:selected) ? options[:selected] : value
        disabled_value = options.has_key?(:disabled) ? options[:disabled] : nil
        content_tag("select", add_options(grouped_options_for_select(choices, :selected => selected_value, :disabled => disabled_value), options, selected_value), html_options)
      end
    end
    
    class FormBuilder
      def grouped_select(method, choices, options = {}, html_options = {})
        @template.grouped_select(@object_name, method, choices, objectify_options(options), @default_options.merge(html_options))
      end
    end
  end
end
