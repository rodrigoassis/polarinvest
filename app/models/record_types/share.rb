class RecordTypes::Share < Record

	validates :asset_id, presence: true
	validates :date, presence: true
	validates :value, presence: true
	validates :value_delta, presence: true
	validates :percentage_delta, presence: true

end