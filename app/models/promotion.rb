class Promotion < ActiveRecord::Base
  has_many :tickets
  belongs_to :restaurant

  after_create :generate_tickets

  validates :name, presence: true
  validates :min_group_size, presence: true
  validates :max_group_size, presence: true
  validates :preferred_group_size, presence: true
  validates :min_spend, presence: true
  validates :loss_tolerance, presence: true
  validates :max_discount, presence: true

  def self.minimum_discount
    0.10
  end

  def generate_tickets
    (min_group_size..max_group_size).each_with_index do |group_size, index|
      ticket_params = {}
      ticket_params[:group_size]      = group_size
      ticket_params[:min_total_spend] = min_spend * group_size
      ticket_params[:discount]        = calculate_discount(group_size, index)
      ticket_params[:active]          = true
      ticket_params[:ticket_price]    = ticket_params[:min_total_spend] - (ticket_params[:min_total_spend] * ticket_params[:discount])

      self.tickets.create(ticket_params)
    end
  end

  def preview_tickets
    tickets = []
    (min_group_size..max_group_size).each_with_index do |group_size, index|
      ticket_params = {}
      ticket_params[:group_size]      = group_size
      ticket_params[:min_total_spend] = format("%.2f" % (min_spend * group_size))
      ticket_params[:discount]        = format("%.2f" % (calculate_discount(group_size, index) * 100))

      tickets << ticket_params
    end
    tickets
  end

  private

  def calculate_discount(group_size, position)
    discount = discount_variance / (max_group_size - min_group_size) * position + self.class.minimum_discount
    if preferred_group_size == group_size && discount < max_discount
      discount += (max_discount / 10)
    end
    discount
  end

  def discount_variance
    max_discount - self.class.minimum_discount
  end
end
