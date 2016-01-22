class Permission < ActiveRecord::Base
  # permission/role associations
  has_and_belongs_to_many :roles

  # permission/task associations
  has_and_belongs_to_many :tasks
end