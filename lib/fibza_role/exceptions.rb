# This error raised when a controller before_filter :check_rights
# learns that the given user is not allowed to executes a controller action
module FibzaRole
  class AccessDenied < StandardError
    attr_reader :action, :subject
    attr_writer :default_message
    
    def initialize(message = nil, action = nil, subject = nil)
      @message = message
      @action = action
      @subject = subject
      @default_message = "You are not authorized to access this page."
    end
    
    def to_s
      @message || @default_message
    end
  end
  
  class CannotAddPermission < StandardError
    attr_reader :action, :subject
    attr_writer :default_message
    
    def initialize(message = nil, action = nil, subject = nil)
      @message = message
      @action = action
      @subject = subject
      @default_message = "Permission cannot added"
    end
    
    def to_s
      @message || @default_message
    end
  end
end