class Option < ActiveRecord::Base
  #after_find :color, :logo 

  def self.color
    Option.last.color
  end
  
  def self.logo
    Option.last.logo
  end

end