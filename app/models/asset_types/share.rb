class AssetTypes::Share < Asset

	validates :ticker, presence: true, uniqueness: true
	validates :name, presence: true

end