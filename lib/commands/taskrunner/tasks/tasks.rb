module Taskrunner
  module Tasks
    def self.included(base)
      base.class_eval do
        desc "case", "task command without namespacing that uses case"
        def case
          case_example = ask 'What is your grade: '
          CaseExample.ask_questions(case_example)
          puts "ran task for role in namespace"
        end

        desc "hello", "task command without namespacing that puts hello"
        def hello
          Says.hello
        end

      end
    end
  end
end
