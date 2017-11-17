module Example
  module First
    def self.role_description
      "Description of Example First Role"
    end
    def self.included(base)
      base.class_eval do
        desc "case", "task command of role in a namespace that uses case"
        def case
          case_example = ask 'What is your grade: '
          CaseExample.ask_questions(case_example)
          puts "ran task for role in namespace"
        end

        desc "hello", "task command of role in a namespace that puts hello"
        def hello
          Says.hello
          puts "rolename"
        end

      end
    end
  end
end
