class Investment < ActiveRecord::Base
  belongs_to :asset
  belongs_to :user

  validates :asset, :user, presence: true
end
