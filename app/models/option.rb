class Option < ActiveRecord::Base
  def self.color
    last.color
  end
end