class CaseExample

  def self.ask_questions(input)
    case input
    when "A"
      puts 'Well done!'
    when "B"
      puts 'Try harder!'
    when "C"
      puts 'You need help!!!'
    else
      puts "You just making it up!"
    end
  end

end
