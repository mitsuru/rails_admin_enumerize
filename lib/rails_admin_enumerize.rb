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
          end
        end

        register_instance_option :http_methods do
          [:post]
        end
      end
    end
  end
end

