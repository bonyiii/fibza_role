class FibzaRoleCreateRoles < ActiveRecord::Migration
  def self.up
    create_table(:roles) do |t|
      t.string :name
      t.text   :description
      t.text   :permissions
      
      #t.text :other_params
      
        
      t.timestamps
    end
  
    create_table "roles_users", :id => false do |t|
      t.integer :role_id, :user_id, :null => false
    end
  
    add_index :roles_users, [:role_id, :user_id], :unique => true
  end

  def self.down
    drop_table :roles_users
    drop_table :roles
  end
end