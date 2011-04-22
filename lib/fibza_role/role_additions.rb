module FibzaRole
  
  # Method additions for role model
  module RoleAdditions
    
    # Each line is a permission for the given role.
    # Namespaced controllers stored in the following format: "namespace/controller::action"
    # Rails params hash stores namespaced controllers this way: "namespace/controller"
    #
    # A permission can be:
    # 1; namespace/controller::action
    # 2; controller::action
    # 3; ontroller::extra_method
    # 4; namespace/controller::extra_method
    #
    # extra_method : app/model/right.rb should contains method named "extra_method" this way
    # the logic defined there, but the action can be assigned to any role.
    #
    # == Params
    # * +subject+ - Namespace/Controller or Controller
    # * +action+ - action / extra method (Defined in right.rb)
    # * +args+ - options 
    # 
    # Permission gets stored in the following format: Controller::action\n
    def add_permission(subject, action, *args)
      self.permissions ||= ""
      unless subject.blank? && action.blank? || has_permission?(subject, action, *args)
        self.permissions += "#{permission_to_s(subject, action, *args)}\n"
        true
      else
        false
      end
    end
    
    def add_permission!(subject, action, *args)
      raise CannotAddPermission("Controller cannot be blank!") if subject.blank?
      raise CannotAddPermission("Action cannot be blank!") if action.blank?
      if add_permission(subject, action, *args) == false
        raise CannotAddPermission
      else
        true
      end
    end
    
    # Revoke a permission from role in question.
    def revoke_permission(subject, action, *args)
      if !permissions.nil? && !subject.blank? && !action.blank? && has_permission?(subject, action, *args)
        self.permissions.sub!("#{permission_to_s(subject, action, *args)}\n","")
        true
      else
        false
      end
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
