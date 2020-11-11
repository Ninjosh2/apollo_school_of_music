class Student < ApplicationRecord
  belongs_to :user
  has_many :lessons
  has_many :teachers, through: :lessons
  validates :name, :phone_number, :instrument, presence: true, uniqueness: {scope: :user_id}
end
