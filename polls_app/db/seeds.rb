# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'



user_id = []

20.times do 
  current = User.create!(username: Faker::Name.unique.name)
  user_id << current.id
end 
user_id_again = user_id.dup.shuffle
user_id = user_id.shuffle
until user_id.empty?
  person = user_id.pop
  rand(1..3).times do 
    Poll.create!(author_id: person, title: Faker::Hipster.word)
  end
end 

Poll.all.each do |one_poll|
  temp = one_poll.id 
    rand(2..4).times do
      Question.create!(poll_id: temp, body: Faker::Quotes::Shakespeare.romeo_and_juliet_quote)
    end 
end 

Question.all.each do |one_q|
  temp = one_q.id 
  whatever = user_id_again.sample(5)
  a = AnswerChoice.create!(question_id: temp, option: "yes")
  Response.create!(user_id:whatever[0],option_id:a.id)
  Response.create!(user_id:whatever[3],option_id:a.id)
  b = AnswerChoice.create!(question_id: temp, option: "no")
  Response.create!(user_id:whatever[1],option_id:b.id)
  Response.create!(user_id:whatever[4],option_id:b.id)
  c = AnswerChoice.create!(question_id: temp, option: "maybe")
  Response.create!(user_id:whatever[2],option_id:c.id)
end 














