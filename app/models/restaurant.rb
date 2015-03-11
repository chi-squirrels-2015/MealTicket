class Restaurant < ActiveRecord::Base
  has_many :promotions
  belongs_to :owner
  
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
          address: self.address

        }
      }]
    }
  end

end
