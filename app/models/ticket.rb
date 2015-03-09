class Ticket < ActiveRecord::Base
  belongs_to :promotion
  has_many :purchases

  validates :active, presence: true

  def deactivate!
    self.update(active: false)
  end
end
