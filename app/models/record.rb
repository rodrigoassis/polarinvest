class Record < ActiveRecord::Base
  belongs_to :asset

  validates :asset_id, :type, :date, :percentage_delta, presence: true

  scope :date_from, lambda {|start_date| select('date, percentage_delta').where("date >= ?", start_date).order('date asc')}
end
