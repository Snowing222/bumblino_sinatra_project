class Comment < ActiveRecord::Base

    belongs_to :playdate
    belongs_to :commentor, class_name: "Parent", foreign_key: "parent_id"
    
end