Parent.delete_all
Baby.delete_all
Playdate.delete_all
BabyPlaydate.delete_all

elsa = Parent.create(name:"elsa", email:"elsa@gmail.com",password:"pw")
anj = Parent.create(name:"anj", email:"anj@gmail.com",password:"pw")

diego = anj.babies.create(name:"diego")
jane = anj.babies.create(name:"jane")

leone = elsa.babies.create(name:"leone")
anna = elsa.babies.create(name:"anna")

@swim = elsa.created_playdates.create(title:"swim", date:"10/10/2020")
@reading = anj.created_playdates.create(title:"reading", date:"10/10/2020")


elsa.babies.each do |baby|
    baby.playdates << @swim
end

anj.babies.each do |baby|
    @reading.babies << baby
end
