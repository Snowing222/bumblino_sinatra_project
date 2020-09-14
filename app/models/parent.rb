class Parent < ActiveRecord::Base
    has_secure_password
    validates :name, :email, presence: true, uniqueness: true
    has_many :babies
    has_many :playdates, through: :babies

    def slug 
        self.name.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        name = slug.gsub("-"," ")
        find_by(name: name)
    end
end