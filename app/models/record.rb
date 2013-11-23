class Record < ActiveRecord::Base
  belongs_to :asset

  validates :asset, :type, :date, :percentage_delta, presence: true
end
