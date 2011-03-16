module FibzaRole
  module Generators
    module OrmHelpers
      def model_exists?(model_name)
        File.exists?(File.join(destination_root, model_path(model_name)))
      end
      
      # I make sure the file name is in underscore format otherwise 
      # it may check for Role.rb which does not exists.
      def model_path(model_name)
        File.join("app", "models", "#{model_name.underscore}.rb")
      end
    end
  end
end