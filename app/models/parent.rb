class Parent < ActiveRecord::Base
    has_secure_password
    validates :name, :email, presence: true
    has_many :babies
    has_many :playdates, through: :babies
    
end