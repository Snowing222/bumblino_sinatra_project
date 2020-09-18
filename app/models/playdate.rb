class Playdate < ActiveRecord::Base
    validates :title, :date, presence: true
    has_many :baby_playdates, dependent: :delete_all
    has_many :babies, through: :baby_playdates
    belongs_to :creator, :class_name => "Parent"
end