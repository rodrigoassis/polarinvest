class Asset < ActiveRecord::Base
  has_many :records, dependent: :destroy
  has_many :investments, dependent: :destroy

  validates :name, :type, presence: true

  # List of every type of assets as a subclass. TODO: Make it not hardcoded
  def self.subclasses
    [AssetTypes::Saving, AssetTypes::Fund]
  end
  
  # Extract the real class name without any module
  def self.clean_name
    self.name.split('::').last
  end

  def values_from start_date
    self.records.date_from(start_date).collect{|record| [record.date.to_time.to_i * 1000, record.percentage_delta.to_f]}
  end
end
