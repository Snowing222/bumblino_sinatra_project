Parent 
Playdate parent_id
Comment  parent_id  playdate_id

<!-- has_many :created_playdates, :class_name => "Playdate", :foreign_key => "parent_id", dependent: :delete_all 
has_many :comments
has_many :commented_playdates, :source => :playdate, through: :comments -->

Parent has many created_playdates, class_name :playdate, foreign key:parent_id
Parent has many commented_playdates, through comments, source:playdate
Parents has many comments

<!-- belongs_to :creator, :class_name => "Parent"
has_many :comments
has_many :commentors, :class_name => "Parent", :foreign_key => "parent_id", through: :comments -->

Playdate belongs_to creator(parent), class_name: parent, foreign key:parent_id
Playdate has many commentor(parent) through comments,source :parent =Playdate.first.commentors
Playdate has many comments

<!-- belongs_to :playdate
belongs_to :commentor, :class_name => "Parent", :foreign_key => "parent_id" -->

Comment belongs to commentor(parent),classname:parent, foreign key:parent_id
Comment belongs to playdate




