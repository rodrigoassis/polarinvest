class Transaction < ActiveRecord::Base
  SAVING = 'InvestmentTypes::Saving'

  belongs_to :investment

  validates :investment_id, :date, :transaction_type, :unit_value, presence: true
  validates :shares_quantity, presence: true, unless: :is_saving?
  validates :shares_quantity, numericality: {only_integer: true, greater_than: 0}, allow_nil: true
  validates :unit_value, format: { with: /^(\$)?(\d+)(\.|,)?\d{0,2}?$/, multiline: true }, numericality: {greater_than: 0}, allow_nil: true

  after_commit :set_total_value

  def self.all_types
    ['Buy', 'Sell']
  end

  private
    def is_saving?
      Investment.where(id: investment_id).first.try(:type) == SAVING
    end

    def set_total_value
      if self.investment.type == SAVING
        self.shares_quantity = 1
      end

      self.update_attributes(total_value: self.shares_quantity * self.unit_value)
    end
end
