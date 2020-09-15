class Baby < ActiveRecord::Base
    validates :name, presence: true
    belongs_to :parent
    has_many :baby_playdates, dependent: :delete_all
    has_many :playdates, through: :baby_playdates 

    
    def slug 
        name.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        name = slug.gsub("-"," ")
        find_by(name: name)
    end
end