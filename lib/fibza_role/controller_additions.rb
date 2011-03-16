module FibzaRole
  module ControllerAdditions
    def self.included(base)
      base.class_eval do
      end
      
      base.extend ClassMethods
    end
    
    module ClassMethods
    end
    
    # Can be called as a before_filter whitin any controller,
    # Checks if current_user can reach the given action.
    #
    # == Example 
    # before_filter :check_rights
    def check_rights(*args)
      if current_user.can?(params[:controller], params[:action], *params)
        return true
      else
        raise AccessDenied.new#(message, action, subject)
      end
    end
    
    # If "controller_action" method exists in "app/models/fibza_role/right.rb", it checks rules defined there.
    # If no such method exists, simply checks whether current_user has a role which has a permission "controller::action".
    # If any returns "true" authorization passese otherwise raise an AccessDenied error.
    #
    # == Params
    # * +controller+ - Name of controller in question
    # * +action+ - Name of action in question
    # * +args+ - Should be a hash of options
    #
    # == Examples
    # authorize!    
    # Do a simple check in a controller method. Only checks if user can access the Controller::method. 
    #
    # authorize! @product
    # Check if user has right to access product model in question. 
    # The controller::method must be defined in right.rb
    def authorize!(*args)
      controller = params[:controller] 
      action = params[:action]

      if FibzaRole::Right.methods.include?("#{controller.underscore}_#{action.downcase}".to_sym)
        authorized = FibzaRole::Right.send("#{controller.underscore}_#{action.downcase}", current_user, *args)
      else
        authorized = current_user.can?(controller, action)
      end
      #raise AccessDenied.new#(message, action, subject) unless authorized
      unless authorized
        raise AccessDenied.new
      else
        authorized
      end
      
    end
    
  end
end

if defined? ActionController
  ActionController::Base.class_eval do
    include FibzaRole::ControllerAdditions
  end
end