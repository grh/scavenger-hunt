class Role < ActiveRecord::Base
  # role/user assocations
  has_and_belongs_to_many :users

  # permission/role associations
  has_and_belongs_to_many :permissions

  def self.default
    find_by_name('participant')
  end
end