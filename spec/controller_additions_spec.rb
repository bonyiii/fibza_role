require 'spec_helper'

describe FibzaRole::ControllerAdditions do

  # Original idea: Cancan by Ryan Bates
  before(:each) do
    @params = HashWithIndifferentAccess.new(:controller => 'users', :action => 'show')
    @controller_class = Class.new
    @controller = @controller_class.new
    @controller.stub(:params) { @params }
    @controller.stub(:current_user) { stub_model(User, :id => 1) }
    #@controller.stub_chain("current_user.roles") { true }
    @controller_class.send(:include, FibzaRole::ControllerAdditions)
  end
  
  it "unauthorized user should raise AccessDenied error" do
    mock_model(User, :id => 1).id.should == @controller.current_user.id
    expect{ @controller.authorize! }.to raise_error(FibzaRole::AccessDenied)
  end
  
  it "authorized user can see index page" do
    @controller.stub_chain("current_user.roles") { true }
    #@controller.current_user.should_receive(:can?).with('users', 'show').and_return(true)
    @controller.authorize!.should be_true
  end
end