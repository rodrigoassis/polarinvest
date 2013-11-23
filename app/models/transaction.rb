class Transaction < ActiveRecord::Base
  belongs_to :investment

  validates :investment, :date, :transaction_type, :total_value, presence: true
end
