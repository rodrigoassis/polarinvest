class RecordTypes::Share < Record

	validates :date, presence: true
	validates :value, presence: true
	validates :value_delta, presence: true
	validates :percentage_delta, presence: true

end