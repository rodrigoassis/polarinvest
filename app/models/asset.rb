class Asset < ActiveRecord::Base
  has_many :records, dependent: :destroy
  has_many :investments, dependent: :destroy

  validates :name, :type, presence: true

  # List of every type of assets as a subclass. TODO: Make it not hardcoded
  def self.subclasses
    [AssetTypes::Saving]
  end
end
