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

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    # Find user with email sent by google
    user = User.where(email: data["email"], provider: "google_oauth2").first

    # Didn't find any user so create one
    unless user
      user = User.create(name: data["name"], email: data["email"], provider: "google_oauth2", password: Devise.friendly_token[0,20])
    end

    return user
  end


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    # Find the user from provider or try to match email
    user = User.where(provider: auth.provider, uid: auth.uid).first || User.where(email: auth.info.email).first
    
    # Didn't find any user so create one
    unless user
      user = User.create(name: auth.extra.raw_info.name, provider: auth.provider, uid: auth.uid, 
                          email: auth.info.email, password: Devise.friendly_token[0,20])
    end
    
    return user
  end


  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    # Find the user from provider or try to match email
    user = User.where(provider: auth.provider, uid: auth.uid).first
    
    # Didn't find any user so create one
    unless user
      user = User.create(name: auth.info.name, provider: auth.provider, uid: auth.uid, 
                          email: "#{auth.info.nickname}@fake-twitter-email.com", password: Devise.friendly_token[0,20])
    end
    
    return user
  end
end
