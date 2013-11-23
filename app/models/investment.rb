class Investment < ActiveRecord::Base
  belongs_to :asset
  belongs_to :user

  has_many :transactions, dependent: :destroy

  validates :asset, :user, presence: true
end
