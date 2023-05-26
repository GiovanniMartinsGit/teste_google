class Merchant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # for Google OmniAuth
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :sale

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |merchant|
      merchant.email = auth.info.email
      merchant.password = Devise.friendly_token[0, 20]
      merchant.name = auth.info.name # assuming the merchant model has a name
      
    end
  end

  private

  def self.current=(merchant)
    Thread.current[:current_merchant]
  end
end
