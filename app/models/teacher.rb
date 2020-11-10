class Teacher < ApplicationRecord

    validates :name, :phone_number, :email, :instrument, presence: true
end
