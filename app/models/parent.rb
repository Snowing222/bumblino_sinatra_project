class Parent < ActiveRecord::Base
    has_secure_password
    validates :name, :email, presence: true, uniqueness: true
    has_many :babies, dependent: :delete_all
    has_many :owned_playdates, :class_name => "Playdate", :foreign_key => "creator_id", dependent: :delete_all
    

    def slug 
        self.name.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        name = slug.gsub("-"," ")
        find_by(name: name)
    end


end