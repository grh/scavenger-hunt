class Task < ActiveRecord::Base
  # permission/task associations
  has_and_belongs_to_many :permissions

  # current_task: finds the task object for the given request params
  # parameters: a controller, action, and request method
  # return value: a task object
  def self.current_task(controller, action, request_method)
    return Task.find_by(controller: controller, action: action, request_method: request_method)
  end
end