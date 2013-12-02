class Transaction < ActiveRecord::Base
  belongs_to :investment

  validates :investment_id, :date, :transaction_type, :total_value, presence: true
  validates :total_value, format: { with: /^(\$)?(\d+)(\.|,)?\d{0,2}?$/, multiline: true }, numericality: {greater_than: 0}, allow_nil: true

  def self.all_types
    ['Buy', 'Sell']
  end
end
