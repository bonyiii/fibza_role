module FibzaRole  
  class Right
    # User defined authorization rules for controller actions, any valid code can  
    # be defined, only requirements is that it must return a single true/false value.
    #
    # == Params
    # Method always has at least two parameters:
    # * +current_user+ - user whose right we check    
    # * +subject+ - model instance in question
    #
    # == Example
    # This case we check UsersController show action
    # We have 4 case
    # 1; User has a "super_admin" role. First if will be true
    # 2; User has one or more role and by evaluate those roles, we found that the user have both permissions. First if will be true.
    # 3; User has one or more role but those role only have permission for "show". Second if will be true.
    # 4; User may or may not has any role but none of his roles permit him for show action. Else branch comes into action and it will be false.  
    # def self.users_show(current_user, subject)
    #   if current_user.can?("Users", "show") && current_user.can?("Users", "see_others")
    #     true
    #   elsif current_user.can?("Users", "show")
    #     subject.id == current_user.id
    #   else
    #     false
    #   end
    # end
    
    def self.users_index(user, *args)
      if user.login == "admin"
        true
      end
    end
    
    def self.users_show(user, subject = nil)
      if user == subject
        true
      end
    end
    
  end
end