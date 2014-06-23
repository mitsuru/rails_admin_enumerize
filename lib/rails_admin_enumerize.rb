require "rails_admin_enumerize/engine"

module RailsAdminEnumerize
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Enumerize < Base
        RailsAdmin::Config::Actions.register(self)
        
        register_instance_option :object_level do
          true
        end
      end
    end
  end
end

