class User < ApplicationRecord
  has_many :students
  has_many :teachers, through: :students
  has_many :lessons, through: :students
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth_2]

  # validates 
end
