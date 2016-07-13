class Role < ActiveRecord::Base
=begin
= DEVELOPER

= ROLE MODEL

  Users can have 1 or more roles; the roles defined for the app are:

  * Guest
  * Participant
  * Owner
  * Admin

  Each role is comprised of 1 or more permissions, and each permission contains 1 or more tasks. If the current user is
  not logged in, the default role of Guest is assigned. Otherwise, the appropriate role for that user is retrieved.

=end

  # role/user assocations
  has_and_belongs_to_many :users

  # permission/role associations
  has_and_belongs_to_many :permissions

  def self.default
    find_by_name('participant')
  end
end