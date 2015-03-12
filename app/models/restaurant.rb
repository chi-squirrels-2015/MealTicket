class Restaurant < ActiveRecord::Base
  has_secure_password
  has_many :promotions

  validates :yelp_id, uniqueness: true
  validates :name, presence: true
  validates :display_phone, presence: true
  validates :address, presence: true
  validates :zipcode, presence: true
  validates :cuisine, presence: true

  geocoded_by :geocoder_address
  after_validation :geocode

  def geocoder_address
    "#{address} #{zipcode}"
  end

  def to_geoJSON
    {
      features: [{
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [self.longitude, self.latitude]
        },
        properties: {
          id: self.id,
          name: self.name,
          address: self.address,
          yelp_id: self.yelp_id
        }
      }]
    }
  end

end
