class FibzaRoleCreate<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    create_table(:<%= table_name %>) do |t|
      t.string :name
      t.text   :description

    <% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
    <% end -%>
      t.timestamps
    end
  
    create_table "<%= rel_table %>", :id => false do |t|
      t.integer :<%= class_name.underscore %>_id, :<%= user_model.underscore %>_id, :null => false
    end
    
     create_table "menus_roles", :id => false do |t|
      t.integer :<%= class_name.underscore %>_id, :menu_id, :null => false
    end
        
    add_index :<%= rel_table %>, [:<%= class_name.underscore %>_id, :<%= user_model.underscore %>_id], :unique => true
    add_index :menus_roles, [:<%= class_name.underscore %>_id, :menu_id], :unique => true
  end

  def self.down
    drop_table :<%= rel_table %>
    drop_table :<%= table_name %>
  end
end