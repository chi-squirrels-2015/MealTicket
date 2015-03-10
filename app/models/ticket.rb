class Ticket < ActiveRecord::Base
  belongs_to :promotion
  has_many :purchases

  def deactivate!
    self.update(active: false)
  end
end
