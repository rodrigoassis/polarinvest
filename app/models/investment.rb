class Investment < ActiveRecord::Base
  belongs_to :asset
  belongs_to :user

  has_many :transactions, dependent: :destroy

  validates :asset_id, :user_id, presence: true

  # List of every type of investments as a subclass. TO-DO: Make it not hardcoded
  def self.subclasses
    [InvestmentTypes::Saving]
  end
end
