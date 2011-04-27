class FibzaRoleCreate<%= "permissions".camelize %> < ActiveRecord::Migration
  def self.up
    create_table(permissions) do |t|
      t.string :controller
      t.string :action
      
      t.timestamps
    end
  
   create_table "permissions_roles", :id => false do |t|
    t.integer :role_id, :permission_id, :null => false
   end
  
   add_index "permissions_roles", [:role_id, :permission_id], :unique => true
  end

  def self.down
    drop_table :<%= table_name %>_<%= user_model.tableize %>
    drop_table :<%= table_name %>
  end
end