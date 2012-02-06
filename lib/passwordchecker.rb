module PasswordChecker

class Checker
  attr_reader :pwd
  def initialize(pwd)
    @pwd = pwd
  end
  
  def password_strength
    str = @pwd.to_s
    total = 0
    str.split(//).each do |c|
       total += (((char_razor(c) ** str.length).to_f) /2880/86400)  /365
    end
    total
  end
  
  private
   
    def char_razor(c)
      case c
      when /[a-zA-z]/
         26
      when  /[0-9]/
        10
      when /[^\w]/ 
         32
      end
    end
  end

end

