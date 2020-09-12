class BabyPlaydate < ActiveRecord::Base
    belongs_to :baby
    belongs_to :playdate
end