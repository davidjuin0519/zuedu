class Order < ActiveRecord::Base
  belongs_to :member
  belongs_to :discount
  has_many :line_items,:dependent => :destroy
  has_many :transactions,:dependent => :destroy
  after_commit :match_discount, on: :create
  before_destroy :can_not_be_destroyed
# for delete order
  enum payment: ['Credit', 'CVS', 'ATM']
  validates :first_name, :last_name, :payment, :email, :address, presence: true 

  def price
    if discount_id
      line_items.to_a.sum(&:price) - line_items.count * discount.factor
    else
      line_items.to_a.sum(&:price)
    end
  end

  def paid?
    transactions.find_by("params -> 'RtnCode' = '1' OR params -> 'TradeStatus' = '1'").present?
  end

private

  def match_discount
    update_column :discount_id, DiscountMatcher.match(self)&.id
  end

  def can_not_be_destroyed
    true
  end

end
