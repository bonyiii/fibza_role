puts "Setting up Default user login"
User.delete_all
user = User.create!(:login => 'admin', :password => 'password')
user = User.create!(:login => 'dummy', :password => 'password')
