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

  def self.translate_asset_name_into_asset_id(params)
    params_modified = params
    params_modified[:asset_id] = Asset.where(name: params_modified[:asset_id]).first.try(:id)
    return params_modified
  end

  # Extract the real class name without any module
  def self.clean_name
    self.name.split('::').last
  end

  def name
    return "#{self.asset.name} - #{self.class.clean_name}"
  end
end
