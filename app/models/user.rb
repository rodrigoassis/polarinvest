class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :investments, dependent: :destroy
  has_many :transactions, through: :investments

  validates :name, presence: true

  # Making user authenticatable through omniauth
  devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :twitter]

  def self.find_for_oauth(auth)
    # Find user with correct provider and uid
    user = User.where(email: auth.info.email).first

    # Didn't find any user so create one
    unless user
      user = User.create(name: auth.info.name, email: (auth.info.email or "#{auth.info.nickname}@fake-twitter-email.com"), 
                        provider: auth.provider, uid: auth.uid, password: Devise.friendly_token[0,20])
    end

    return user
  end
end
