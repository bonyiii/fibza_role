require "fibza_role/controller_additions"
#require_dependency "fibza_role/exceptions"
#require_dependency "fibza_role/user_additions"

module FibzaRole
##    autoload :ControllerAdditions, "fibza_role/controller_additions"
    autoload :AccessDenied, "fibza_role/exceptions"
    autoload :UserAdditions, "fibza_role/user_additions"
end
