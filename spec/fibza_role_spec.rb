require 'spec_helper'
require 'fixtures/right.rb'

describe FibzaRole do
  
  let(:user) do 
    User.new 
  end
  
  let(:visitor) do
    user = User.new
    user.roles = [ stub_model(Role, :name => "visitor") ]
    user
  end
  
  let(:super_admin) do
    user = User.new
    user.roles = [ stub_model(Role, :name => "super_admin"), stub_model(Role, :name => "visitor") ]
    user
  end
  
  it "User model should exists" do
    user.should be_true
  end
  
  it "Role model require at least a name attribute and should exists" do
    Role.new(:name => "admin").should be_true
  end
  
  it "user may have multiple roles" do
    user.roles << stub_model(Role, :name => "another")
    user.roles << stub_model(Role, :name => "yet_anoter")
    user.roles.size.should == 2
  end
  
  it "cannot is opposite of can" do
    user.can?("users_controller", "show").should be_false
    user.cannot?("users_controller", "show").should be_true
  end
  
  it "super_admin can do anything, call even non existent controller action" do
    super_admin.can?("do", "anything").should be_true
    visitor.can?("do", "anything").should be_false
  end
  
  it "u can stub" do
    user.stub!(:roles).and_return(true)
    user.roles.should be_true
  end
  
  describe "role" do
    
    let(:role_test) { stub_model(Role, :name => "test") }
    
    it "a permission can assigned to a role only once" do
      role_test.add_permission("Controller", "action")
      role_test.add_permission("Controller", "action")
      role_test.add_permission("Controller", "actION")
      role_test.permissions.scan(/Controller::action/i).size.should eq(1)
    end
    
    it "user can access the right permissions" do
      visitor.roles.first.add_permission("Controller", "action2")
      visitor.can?("Controller", "action").should be_false
    end
    
    it "could have many permissions" do
      role_test.add_permission("Controller", "action")
      role_test.add_permission("Controller", "action2")
      role_test.permissions.scan(/^controller::action$/m).size.should eq(1)
      role_test.permissions.scan(/^controller::action2$/m).size.should eq(1)
    end
    
    it "permissions could be revoked" do
      role_test.add_permission("SuperController", "action")
      role_test.permissions.scan("super_controller::action").size.should == 1
      role_test.revoke_permission("SuperController", "action")
      role_test.has_permission?("SuperController", "action").should be_false
      role_test.permissions.include?("SuperController").should be_false
      role_test.permissions.scan(/super_controller::action/).size.should == 0
    end
    
    it "permissions names are key insensitive but controller name has to follow CamelCase2under_score rules" do
      role_test.add_permission("cONTroller", "actION")
      role_test.revoke_permission("ContRoLLer", "ACTiON")
      role_test.has_permission?("cONTroller", "ACTiON").should be_true
      role_test.revoke_permission("cONTroller", "ACTiON")
      role_test.has_permission?("cONTroller", "ACTiON").should be_false
    end
    
    it "permission controllers can be namespaced" do
      role_test.add_permission("namespace/controller","index")
      role_test.has_permission?("namespace/controller","index").should be_true
    end
    
    it "permissions can be nil" do
      role_test.permissions.should be_nil
    end
    
    it "add_permission/revoke_permission handles nil parameters" do
      role_test.add_permission(nil,nil).should be_false
      role_test.revoke_permission(nil,nil).should be_false
      expect{ role_test.add_permission(nil,nil) }.to_not raise_error
      expect{ role_test.revoke_permission(nil,nil) }.to_not raise_error
    end
    
    it "add_permsission warns if a permission already assigned to role" do
      role_test.add_permission("Controller", "action").should be_true
      role_test.add_permission("Controller", "action").should be_false
    end
    
    it "revoke_permsission warns if a permission already assigned to role" do
      role_test.add_permission("Controller", "action").should be_true
      role_test.revoke_permission("Controller", "action").should be_true
      role_test.revoke_permission("Controller", "action").should be_false
    end
    
  end
  
end