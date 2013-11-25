class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :investments, dependent: :destroy

  validates :name, presence: true

  # Making user authenticatable through omniauth
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    # Find user with email sent by google
    user = User.where(:email => data["email"]).first

    # Didn't find any user so create one
    unless user
      user = User.create(name: data["name"], email: data["email"], password: Devise.friendly_token[0,20])
    end

    return user
  end
end
