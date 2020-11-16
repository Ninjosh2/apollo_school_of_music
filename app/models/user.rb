class User < ApplicationRecord
  has_many :students
  has_many :teachers, through: :students
  has_many :lessons, through: :students

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # def self.from_google(uid:, email:, full_name:, avatar_url:)
  #   user = User.find_or_create_by(email: email) do |u|
  #     u.uid = uid
  #     u.full_name = full_name
  #     u.avatar_url = avatar_url
  #     u.password = SecureRandom.hex
  #   end
  #     user.update(uid: uid, full_name: full_name, avatar_url: avatar_url)
  #     user
  # end

end