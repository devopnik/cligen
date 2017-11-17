module Generate
  module New
    def self.role_description
      "Generates new task runners from templates"
    end
    def self.included(base)
      base.class_eval do
        desc "role", "generates new role command for a provided namespace"
        def role
          namespace = ask 'namespace:'
          role_names = ask 'List role names separated by commas'
          role_names = role_names.downcase.split(/\s*,\s*/)
          describe_roles = Hash[role_names.zip []]
          describe_roles.each { |r,d | describe_roles[r], d = ask "Add description for #{r} "}
          Generators.generate(namespace.downcase, describe_roles)
        end

        desc "runner", "generates new task runner"
        def runner
          namespace = ask 'Task Runner Name:'
          describe_runner = ask "Add description for #{namespace}"
          Generators.generate(namespace, describe_runner)
        end

      end
    end
  end
end
