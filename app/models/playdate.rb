class Playdate < ActiveRecord::Base
    validates :title, :date, presence: true
    has_many :baby_playdates
    has_many :babies, through: :baby_playdates
    belongs_to :parent
end