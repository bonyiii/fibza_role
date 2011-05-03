#require 'rails/generators/active_record'

module FibzaRole
  
  class FibzaRoleGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    
    desc "Generates a role and permission models and connect it with user model"
    
    # This hook calls the orm specific db_role generator for example: active_record
    # from the folder plugins/db_role/generators/active_record/db_role
    hook_for :orm, :required => true
    
    #namespace :db_role
    
    def generate_fibza_role_right
      copy_file "right.rb", "app/models/fibza_role/right.rb"
    end
    
  end
  
end