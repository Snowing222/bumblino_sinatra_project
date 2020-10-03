class Playdate < ActiveRecord::Base
    validates :title, :date, presence: true
    has_many :baby_playdates, dependent: :delete_all
    has_many :babies, through: :baby_playdates
   
    belongs_to :creator, class_name: "Parent", foreign_key: "parent_id"
    has_many :comments
    has_many :commentors, through: :comments, source: :commentor

    has_many :attend_playdates
    has_many :attended_parents, through: :attend_playdates, source: :parent
end