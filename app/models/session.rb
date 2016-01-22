class Session < ActiveRecord::Base
  belongs_to :user

  # logout: class method that updates deleted_at time upon logout
  # parameters: a session id
  # return value: none
  def self.logout(session_id)
    return find_by_session_id(session_id).update(deleted_at: Time.now)
  end
end