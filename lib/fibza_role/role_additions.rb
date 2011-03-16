module FibzaRole

  # Method additions for role model
  module RoleAdditions
    
    # Each line line is a permission accessible for role.
    # A permission can be
    # 1; Controller::action
    # 2; Controller::extra_method
    # In the second case the app/model/right.rb should refer to extra_method this way
    # the authorization logic defined there but that special role can be assigned to any
    # role in the database.  
    #
    # == Params
    # * +subject+ - Controller
    # * +action+ - action / unique method
    # * +args+ - options 
    # 
    # Permission gets stored in the following format: Controller::action\n
    def add_permission(subject, action, *args)
      self.permissions ||= ""
      self.permissions += "#{permission_to_s(subject, action, *args)}\n" unless has_permission?(subject, action, *args)
    end
    
    # Revoke a permission from role in question.
    def revoke_permission(subject, action, *args)
      self.permissions.sub!("#{permission_to_s(subject, action, *args)}\n","") unless permissions.nil?
    end
    
    # Checks if the role in question are permitted to executes the given action.
    def has_permission?(subject, action, *args)
     (!permissions.nil? && permissions.match(/^#{permission_to_s(subject, action, *args)}$/)) ? true : false
    end
    
    private
    
    def permission_to_s(subject, action, *args)
      "#{subject.underscore}::#{action.downcase}"
    end

  end

end
