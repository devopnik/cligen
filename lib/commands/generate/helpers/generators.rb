require 'erb'
require 'fileutils'

class Generators
  attr_accessor :namespace, :role, :described_namespace, :description

  def template_binding
    binding
  end

  def self.generate(namespace, described_namespace)
    if described_namespace.is_a?(Hash)
      described_namespace.each do |role,description|
        if File.file?("lib/commands/#{namespace}/#{role}/tasks/tasks.rb")
          puts "ABORT: #{namespace} already exists as a namespace with tasks"
        elsif role.downcase == 'tasks'
          puts "ABORT: #{role} is a protected namespace for the runner role, it cannot be used, choose a modifier"
        else
          File.expand_path(File.dirname(__FILE__) + '/../lib')
          FileUtils::mkdir_p("lib/commands/#{namespace}/#{role}/helpers")
          FileUtils::mkdir_p("lib/commands/#{namespace}/#{role}/tasks")
          new_file = File.open("lib/commands/#{namespace}/#{role}/tasks/tasks.rb", "w+")
          template = File.read("templates/tasks.rb.erb")
          insert = Generators.new
          insert.namespace = namespace.capitalize
          insert.role = role.capitalize
          insert.description = description.gsub(/([a-z])((?:[^.?!]|\.(?=[a-z]))*)/i) { $1.upcase + $2.rstrip } #format sentences
          new_file << ERB.new(template).result(insert.template_binding)
          new_file.close
          FileUtils.cp("templates/bin", "bin/#{namespace}")
        end
      end

    else
      if File.file?("lib/commands/#{namespace}/tasks/tasks.rb")
        puts "ABORT: #{namespace} already exists as a task runner"
      else
        File.expand_path(File.dirname(__FILE__) + '/../lib')
        FileUtils::mkdir_p("lib/commands/#{namespace}/helpers")
        FileUtils::mkdir_p("lib/commands/#{namespace}/tasks")
        new_file = File.open("lib/commands/#{namespace}/tasks/tasks.rb", "w+")
        template = File.read("templates/tasks.rb.erb")
        insert = Generators.new
        insert.namespace = namespace.capitalize
        insert.described_namespace = described_namespace.gsub(/([a-z])((?:[^.?!]|\.(?=[a-z]))*)/i) { $1.upcase + $2.rstrip }
        new_file << ERB.new(template).result(insert.template_binding)
        new_file.close
        FileUtils.cp("templates/bin", "bin/#{namespace}")
      end

    end
  end
end
