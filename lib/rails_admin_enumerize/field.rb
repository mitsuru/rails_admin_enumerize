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

          register_instance_option :enum_method do
            @enum_method ||= bindings[:object].class.respond_to?("#{name}_enum") || bindings[:object].respond_to?("#{name}_enum") ? "#{name}_enum" : name
          end

          register_instance_option :enum do
            bindings[:object].class.respond_to?(enum_method) ? bindings[:object].class.send(enum_method) : bindings[:object].send(enum_method)
          end

          register_instance_option :multiple? do
            properties && [:serialized].include?(properties.type)
          end

          register_instance_option :pretty_value do
            options = @abstract_model.model.send(name).options
            result = ''
            btns = options.map do |k,v|
              bindings[:view].link_to(
                k.html_safe,
                enumerize_path(model_name: @abstract_model, id: bindings[:object].id, method: name, value: v),
                class: 'btn btn-info btn-mini' + (v == value ? ' active' : ''),
                onclick: 'var $t = $(this); $t.html("<i class=\"fa fa-spinner fa-spin\"></i>"); $.ajax({type: "POST", url: $t.attr("href"), data: {ajax:true}, success: function(r) { $t.attr("href", r.href); $t.attr("class", r.class + " active"); $t.text(r.text); }, error: function(e) { console.log(e); }}); return false;'
              )
            end
            bindings[:view].content_tag(:div, btns.join('').html_safe, class: 'btn-group alignment', :data => {toggle: 'buttons-radio' }).html_safe
          end
        end
      end
    end
  end
end

