class Option < ActiveRecord::Base

  def self.color
    option.last.color
  end
  
  def self.logo
    option.last.logo
  end

end