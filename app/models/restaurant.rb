class Restaurant < ActiveRecord::Base
  has_secure_password
  has_many :active_unexpired_promotions, -> { where(active: true).where("valid_on >= '#{Date.today}'") }, class_name: "Promotion"
  has_many :expired_promotions, -> { where("valid_on < '#{Date.today}'")}, class_name: "Promotion"
  has_many :inactive_promotions, -> { where(active: false) }, class_name: "Promotion"
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
          yelp_id: self.yelp_id,
          active_promotions: self.active_unexpired_promotions.count,
          max_discount: ((self.active_unexpired_promotions.max_by(&:max_discount).try(:max_discount) || 0) * 100).to_i
        }
      }]
    }
  end

end
