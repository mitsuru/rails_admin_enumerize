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
            ajax_link = Proc.new do |fv, val, badge|
              render json: {
                text: fv.html_safe,
                href: enumerize_path(model_name: @abstract_model, id: @object.id, method: @meth, value: val.to_s),
                class: 'btn btn-info btn-mini'
              }
            end

            if params['id'].present?
              begin
                @object = @abstract_model.model.find(params['id'])
                @meth = params[:method]
                @object.send(@meth + '=', params[:value])
                if @object.save
                  if params['ajax'].present?
                    ajax_link.call(params[:value], params[:value], '')
                  else
                    flash[:success] = I18n.t('admin.enumerize.updated', attr: @meth)
                  end
                else 
                  if params['ajax'].present?
                    render text: @object.errors.full_messages.join(', '), layout: false, status: 422
                  else
                    flash[:error] = @object.errors.full_messages.join(', ')
                  end
                end
              rescue Exception => e
                if params['ajax'].present?
                  render text: I18n.t('admin.toggle.error', err: e.to_s), status: 422
                else
                  flash[:error] = I18n.t('admin.toggle.error', err: e.to_s)
                end
              end
            else
              if params['ajax'].present?
                render text: I18n.t('admin.toggle.no_id'), status: 422
              else
                flash[:error] = I18n.t('admin.toggle.no_id')
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

