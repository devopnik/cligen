module Example
  module Second
    def self.role_description
      "Description of Example Second Role"
    end
    def self.included(base)
      base.class_eval do

        no_tasks {
          def in_module_non_task
            puts "in_module_non_task method called: not a task with a description, methods in no_tasks block can be called by other tasks"
          end
        }

        description="Description of the task"
        desc "taskname", description
        long_desc <<-LONGDESC
            #{description}\n
            In the longer form, you can explain in detail how the task should be run and what output to expect:\n
            Example: taskname -f first -s second -t third\n
            Outputs: { output description here }\n
          LONGDESC
        option :first, :required => true, :aliases => ["-f", "--first"]
        option :second, :aliases => ["-s", "--second"]
        option :third, :aliases => ["-t", "--third"]
        def taskname
          puts " -f #{options[:first]} is a required parameter, and won't run without being passed in as an argument"
          puts options[:second] || 'default second option value'
          puts options[:third] || 'default third option value'
          # task logic goes in this section
          puts ""
          in_module_non_task
        end

      end
    end
  end
end
