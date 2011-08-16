# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "fibza_role"
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.version = "0.0.1"
  
  s.author = "Bonaventura Fleischmann"
  s.email = "boni@twine.hu"
  s.homepage = "http://github.com/bonyiii/db_role"
  s.summary = "Database base authorization solution for Rails."
  s.description = "Database based authorization. Users may have multipel roles. Handling controller actions acls and model attribute read/write premissions"
  s.add_runtime_dependency("rails")
end