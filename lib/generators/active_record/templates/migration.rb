class FibzaRoleCreate<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    create_table(:<%= table_name %>) do |t|
      t.string :name
      t.text   :description
      t.text   :permissions
      
      #t.text :other_params
      
    <% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
    <% end -%>
    
      t.timestamps
    end
  
    create_table "<%= rel_table %>", :id => false do |t|
      t.integer :<%= class_name.underscore %>_id, :<%= user_model.underscore %>_id, :null => false
    end
    
    add_index :<%= rel_table %>, [:<%= class_name.underscore %>_id, :<%= user_model.underscore %>_id], :unique => true
    
  end

  def self.down
    drop_table :<%= rel_table %>
    drop_table :<%= table_name %>
  end
end