class Role < ActiveRecord::Base
  include FibzaRole::RoleAdditions
  
  has_and_belongs_to_many :users
  
  validates_presence_of :name
end
