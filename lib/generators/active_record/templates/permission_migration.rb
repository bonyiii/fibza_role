class FibzaRoleCreate<%= "permissions".camelize %> < ActiveRecord::Migration
  def self.up
    create_table(:<%= permission_model.tableize %>) do |t|
      t.string :controller
      t.string :action
      
      t.timestamps
    end
  
   create_table "<%= permission_rel_table %>", :id => false do |t|
    t.integer :<%= class_name.underscore %>_id, :<%= permission_model.underscore %>_id, :null => false
   end
  
   add_index "<%= permission_rel_table %>", [ :<%= class_name.underscore %>_id, :<%= permission_model.underscore %>_id ], :unique => true
   add_index :<%= permission_model.tableize %>, [ :controller, :action ], :unique => true
  end

  def self.down
    drop_table :<%= permission_rel_table %>
  end
end