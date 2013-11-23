class Asset < ActiveRecord::Base
  has_many :records, dependent: :destroy
  has_many :investments, dependent: :destroy
end
