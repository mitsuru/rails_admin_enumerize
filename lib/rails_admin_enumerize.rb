require 'rails_admin_enumerize/field'
require "rails_admin_enumerize/engine"

module RailsAdminEnumerize
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Enumerize < Base
        RailsAdmin::Config::Actions.register(self)
        
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          false
        end

        register_instance_option :member? do
          true
        end

        register_instance_option :controller do
          proc do
            if params['id'].present?
              begin
                @object = @abstract_model.model.find(params['id'])
                @meth = params[:method]
                @object.send(@meth + '=', params[:value])
                if @object.save
                  if params['ajax'].present?
                  else
                    flash[:success] = I18n.t('admin.enumerize.updated', attr: @meth)
                  end
                end
              end
            end

            redirect_to :back unless params['ajax'].present?
          end
        end

        register_instance_option :http_methods do
          [:post]
        end
      end
    end
  end
end

