# All interface and framework requirements can go into this module
# Some class methods to be made available may include things related to validations and user input, though validations could exist in a separate module
# TODO:
#   - import descriptions for roles
#   - intuit if it is a namespaced role task or a direct task runner
['thor','helpers'].each { |add| Dir["#{File.dirname(__FILE__)}/#{add}/**/*.rb"].each {|file| require file } }
module Interface

  class RoleCommands < Thor
    def self.banner(command, namespace = nil, subcommand = false) # Sets a template for commands and task descriptions, args are Thor specific, cannot rename
      "#{basename} #{role_command} #{command.usage}"
    end

    def self.role_command
      msg = "ERROR: #{self.name} is an invalid class name for role. Do not use CamelCase for Role class namespace"
      self.name =~ /^[A-Z]\w+(?:[A-Z]\w+){1,}/x ? raise(msg) : self.name.downcase
    end
  end

  class Paths
    def self.load(namespace)

      Dir["#{File.dirname(__FILE__)}/commands/#{namespace}/**/*.rb"].each {|file| require file }

      if File.directory? "#{File.dirname(__FILE__)}/commands/#{namespace}/tasks"
        cli_runner = Class.new(Thor)
        cli_runner = Object::const_set('Runner', cli_runner)
        cli_runner.class_eval do
          include Object.const_get("#{namespace.capitalize}::Tasks")
        end

      else
        roles = []
        Dir["#{File.dirname(__FILE__)}/commands/#{namespace}/*"].each do |e|
          unless File.basename(e) == 'helpers'
           roles << File.basename(e)
          end
        end

        roles.each do |role|
          klass = Class.new(RoleCommands)
          klass = Object::const_set(role.capitalize, klass)
          klass.class_eval do
            include Object.const_get("#{namespace.capitalize}::#{role.capitalize}")
          end
        end

        cli_runner = Class.new(Thor)
        cli_runner = Object::const_set('Runner', cli_runner)
        roles.each do |role|
          description = Object.const_get("#{namespace.capitalize}::#{role.capitalize}").role_description rescue nil
          cli_runner.class_eval do |runner|
            runner.desc "#{role}", description ||= "This is a namespaced role that has tasks"
            runner.subcommand "#{role}", Object::const_get(role.capitalize)
          end
        end

      end

    end
  end
end
