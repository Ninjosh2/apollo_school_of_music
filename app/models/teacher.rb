class Teacher < ApplicationRecord
    has_many :lessons 
	has_many :students, through: :lessons 


    validates :name, :phone_number, :email, :instrument, presence: true
end
