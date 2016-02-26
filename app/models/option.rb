class Option < ActiveRecord::Base
  def self.color
    return last.color
  end
  
  def self.logo
    return last.logo
  end

  # create: insert an option object into db
  # parameters: none
  # return value: true/false, depending on success/failure of creation
  def create
    return self.save
  end
end