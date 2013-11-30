class Investment < ActiveRecord::Base
  belongs_to :asset
  belongs_to :user

  has_many :transactions, dependent: :destroy

  validates :asset_id, :user_id, presence: true

  # List of every type of investments as a subclass. TO-DO: Make it not hardcoded
  def self.subclasses
    [InvestmentTypes::Saving]
  end

  def translate_asset_id_into_asset_name(params)
    params_modified = params
    params_modified[:asset_id] = Asset.where(name: params_modified[:asset_id]).first.id
    return params_modified
  end

  def invesment_asset_name
    return Asset.find(self.asset_id).name
  end
end
