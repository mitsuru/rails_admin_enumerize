require 'builder'

module RailsAdmin
  module Config
    module Fields
      module Types
        class Enumerize < RailsAdmin::Config::Fields::Base
          # Register field type for the type loader
          RailsAdmin::Config::Fields::Types::register(self)
          include RailsAdmin::Engine.routes.url_helpers

          register_instance_option :view_helper do
            :check_box
          end

          register_instance_option :pretty_value do
            options = @abstract_model.model.send(name).options
            result = ''
            options.each do |k,v|
              result += bindings[:view].button_tag v, class: 'btn btn-info btn-mini' + (v == value ? ' active' : ''), onclick: 'return false;'

            end
            bindings[:view].content_tag(:div, result.html_safe, class: 'btn-group alignment', :data => {toggle: 'buttons-radio' }).html_safe
          end
        end
      end
    end
  end
end

