class Baby < ActiveRecord::Base
    validates :name, presence: true
    belongs_to :parent
    has_many :baby_playdates
    has_many :playdates, through: :baby_playdates 
end