# Borrowed from devise generators.
# https://github.com/plataformatec/devise/tree/master/lib/generators/devise
require 'generators/orm_helpers'
require 'rails/generators/active_record'

# This module gets invoked by standard db_role generator. The hook_for :orm
# initialize the neccessary ORM engine (active_record, mongoid)
module ActiveRecord
  module Generators
    
    # Since ActiveRecord::Generators extends Rails::Generators::NameBased
    # a "name" argument is available. The ¨name" argument means the "role" model.
    class FibzaRoleGenerator < ActiveRecord::Generators::Base
      argument :user_model, :type => :string, :default => 'User', :banner => "User model name" #, :optional => false      
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      
      include FibzaRole::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)
      
      def generate_model
        unless model_exists?(name) && behavior == :invoke
          # We invoking active_record in template file we adding all the
          # attributes that got passed to the generator.
          invoke "active_record:model", [name], :migration => false
          invoke "active_record:model", permission, :migration => false
        else
          puts "Model #{name} already exists"
        end
      end
      
      def copy_migration
        migration_template "migration.rb", File.join(Rails.root,"db","migrate","fibza_role_create_#{table_name}")
        migration_template "permission_migration.rb", File.join(Rails.root,"db","migrate","fibza_role_create_permissions")
      end
      
      def inject_role_model_content
        inject_into_class(model_path(name), class_name, role_contents) if model_exists?(name) 
      end
      
      def inject_user_model_content
        inject_into_class(model_path(user_model), class_name, user_contents) if model_exists?(user_model)
      end
      
      private
      
      def role_contents
        <<CONTENT
  include FibzaRole::RoleAdditions
  
  has_and_belongs_to_many :#{user_model.tableize}
  has_and_belongs_to_many :permission
  validates_presence_of :name
  validates_uniqueness_of :name
CONTENT
      end
      
      def user_contents
        <<CONTENT
  include FibzaRole::UserAdditions
  
  has_and_belongs_to_many :#{table_name}
CONTENT
      end

      def permission_contents
        <<CONTENT
  
  has_and_belongs_to_many :#{table_name}
CONTENT
      end
      
      def rel_table
        if table_name.downcase[0] > user_model.downcase[0]
          return "#{user_model.tableize}_#{table_name}"
        else
          return "#{table_name}_#{user_model.tableize}"
        end
      end
      
    end
  end
end