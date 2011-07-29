module FibzaRole
  
  # Should be included in current_user model class.
  # Process authorization for current_user.
  module UserAdditions
    
    module ClassMethods
    end
    
    def self.inlcuded(base)
      base.class_eval do
        
      end
      
      base.extend(ClassMethods)
    end
    
    # If a permission listed in role permissions, it has right to execute action, otherwise not.
    # If super_admin role enabled, user who has super_admin role can ACCESS EVERYTHING!
    # 
    # == Params
    # * +controller+ - controller in question
    # * +action+ - controller's action in question
    # * +args+ - anything else
    #
    # == Example 
    # Can current_user reach users controller index action?
    # current_user.can?("Users", "index")
    #
    def can?(controller, action, *args)
      return true if has_role?("super_admin")
      @_permissions ||= roles.inject([]){ |all, role| all + role.permissions.to_a }
      
      @_permissions.detect do |permission|
        permission.controller == controller.underscore && permission.action == action.downcase
      end ? true : false
    end
    
    # Convenience method, inverses can method.
    def cannot?(controller, action, *args)
      !can?(controller, action, *args)
    end
    
    #private
    
    # Checks if current_user has given role? 
    # If roles include super_admin it gives true back anyway. 
    def has_role?(role_in_question)
      @_roles_list ||= self.roles.collect(&:name)
      return true if @_roles_list.include?("super_admin")
       (@_roles_list.include?(role_in_question.to_s) )
    end
    
  end
  
end