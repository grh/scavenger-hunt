class Option < ActiveRecord::Base

  def self.color
    Option.last.color
  end
  
  def self.logo
    Option.last.logo
  end

end