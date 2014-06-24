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
            btns = options.map do |k,v|
              bindings[:view].link_to(
                v.html_safe,
                enumerize_path(model_name: @abstract_model, id: bindings[:object].id, method: name, value: v),
                class: 'btn btn-info btn-mini' + (v == value ? ' active' : ''),
                method: :post
              )
            end
            bindings[:view].content_tag(:div, btns.join('').html_safe, class: 'btn-group alignment', :data => {toggle: 'buttons-radio' }).html_safe
          end
        end
      end
    end
  end
end

