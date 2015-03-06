class Restaurant < ActiveRecord::Base
  has_many :promotions
end
