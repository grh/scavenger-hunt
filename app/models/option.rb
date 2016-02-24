class Option < ActiveRecord::Base
  belongs_to :user
  
  # update: updates the options theme with logo and color
  # parameters: option_params
  # return value: success or failure
  def update(option_params, user)
    # refer to events.rb 48 for update? method example -bw
    status = false
    
    # update color & logo
    self.color << color
    self.logo << logo
    
    if self.save
      self.admin << user
      status = true
    end
    return status
  end
  
  def option_params
    params.require(:logo).permit(:color)
  end
end