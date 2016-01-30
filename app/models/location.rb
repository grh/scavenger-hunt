class Location < ActiveRecord::Base
  # location/user associations
  has_and_belongs_to_many :owner, class_name: 'User', join_table: 'owned_locations'
  has_many :visits
  has_many :visitors, through: :visits, source: 'user'

  # event/location associations
  has_and_belongs_to_many :events

  # qrcode: generates a qr code
  # parameters: none
  # return value: a qr code
  def qrcode
    @qr = RQRCode::QRCode.new("http://0.0.0.0:3000/visit/#{self.tag}", :size => 6)
    return @qr
  end

  # create: creates a new location and saves to the database
  # parameters: location_params
  # return value: success or failure
  def create(location_params, user)
    status = false

    # generate random tag
    self.tag = (('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a).shuffle[0..7].join

    if self.save
      self.owner << user
      status = true
    end
    return status
  end
end