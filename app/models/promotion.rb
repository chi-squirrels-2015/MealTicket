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
  validates :available_budget, presence: true
  validates :max_discount, presence: true
  validates :restaurant_id, presence: true

  before_validation :set_available_budget, on: :create

  def self.minimum_discount
    0.10
  end

  def generate_tickets
    tickets_for_groups(min_group_size, max_group_size) do |ticket_params|
      self.tickets.create(ticket_params)
    end
  end

  def preview_tickets
    tickets_for_groups(min_group_size, max_group_size)
  end

  def update_available_budget(loss)
    self.update(available_budget: self.available_budget - loss)
  end

  def update_tickets
    bogus_tickets = self.tickets.select {|t| available_budget < t.loss_per_ticket}
    bogus_tickets.map(&:deactivate!)
  end

  private

  def ticket_params(group_size, index)
    min_total_spend = min_spend * group_size
    discount        = calculate_discount(group_size, index)
    loss_per_ticket = min_total_spend * discount
    ticket_price    = min_total_spend - (min_total_spend * discount)
    {
      group_size: group_size,
      min_total_spend: min_total_spend.round(2),
      discount: discount.round(2),
      loss_per_ticket: loss_per_ticket.round(2),
      ticket_price: ticket_price.round(2),
      active: true
    }
  end

  def tickets_for_groups(min_group_size, max_group_size)
    (min_group_size..max_group_size).each_with_index.map do |group_size, index|
      ticket = ticket_params(group_size, index)
      if block_given?
        yield ticket
      else
        ticket
      end
    end
  end

  def set_available_budget
    self[:available_budget] ||= loss_tolerance
  end

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
