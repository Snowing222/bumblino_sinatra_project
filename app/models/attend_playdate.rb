class AttendPlaydate < ActiveRecord::Base
    belongs_to :parent
    belongs_to :playdate
end