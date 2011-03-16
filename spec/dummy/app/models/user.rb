class User < ActiveRecord::Base
  include FibzaRole::UserAdditions
  
  has_and_belongs_to_many :roles
end
