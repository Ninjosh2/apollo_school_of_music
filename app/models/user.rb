class User < ApplicationRecord
  has_many :students
  has_many :teachers, through: :students
  has_many :lessons, through: :students

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  # def self.from_google(uid:, email:, full_name:, avatar_url:)
  #   if user = User.find_by(email: email)
  #     user.update(uid: uid, full_name: full_name, avatar_url: avatar_url) unless user.uid.present?
  #     user
  #   else
  #     User.create(
  #       email: email,
  #       uid: uid,
  #       full_name: full_name,
  #       avatar_url: avatar_url,
  #       password: SecureRandom.hex
  #     )
  #   end
  # end

  validates :password, :presence => true,
  :confirmation => true,
  :length => {:within => 6..40},
  :on => :create

  validates :email, uniqueness: true
  validates :email, presence: true  

  def self.create_from_github_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create! do |user|
      user.email = provider_data.info.email || "github@test.com"
      user.password = Devise.friendly_token[0, 20]
    end
  end
end