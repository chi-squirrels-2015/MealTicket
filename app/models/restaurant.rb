class Restaurant < ActiveRecord::Base
  has_many :promotions

  validates :yelp_id, uniqueness: true
  validates :name, presence: true
  validates :display_phone, presence: true
  validates :address, presence: true
  validates :zipcode, presence: true
  validates :cuisine, presence: true
end
