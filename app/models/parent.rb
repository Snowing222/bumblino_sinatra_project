class Parent < ActiveRecord::Base
    has_secure_password
    validates :name, :email, presence: true, uniqueness: true
    has_many :babies, dependent: :delete_all

    has_many :created_playdates, class_name: "Playdate", foreign_key: "parent_id", dependent: :delete_all 
    has_many :comments
    has_many :commented_playdates, source: :playdate, through: :comments

    has_many :attend_playdates
    has_many :attended_playdates, through: :attend_playdates, source: :playdate
   
    def slug 
        self.name.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        name = slug.gsub("-"," ")
        find_by(name: name)
    end


end