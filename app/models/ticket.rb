class Ticket < ActiveRecord::Base
  belongs_to :promotion
  has_many :purchases
end
