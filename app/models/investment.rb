class Investment < ActiveRecord::Base
  belongs_to :asset
  belongs_to :user

  has_many :transactions, dependent: :destroy

  validates :user_id, presence: true
  validates :asset_id, presence: {message: "blank or not found"}

  # List of every type of investments as a subclass. TODO: Make it not hardcoded
  def self.subclasses
    [InvestmentTypes::Saving]
  end

  def self.translate_asset_id_into_asset_name(params)
    params_modified = params
    params_modified[:asset_id] = Asset.where(name: params_modified[:asset_id]).first.try(:id)
    return params_modified
  end

  def invesment_asset_name
    return Asset.find(self.asset_id).name
  end
end
