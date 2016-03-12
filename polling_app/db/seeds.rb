# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


50.times { User.create!(name: Faker::Name.name)}

5.times {Poll.create!(title: Faker::Lorem.sentence, author_id: rand(1..50))}

Poll.all.each do |poll|
  5.times do
    q = Question.create!(poll_id: poll.id, text: Faker::Lorem.sentence)
    4.times do
      AnswerChoice.create!(question_id: q.id, text: Faker::Lorem.sentence)
    end
  end
end

# User.all.each do |user|
#   Question.all.each do |question|
#     answer_choice = question.answer_choices[rand(0..3)]
#     Response.create!(answer_choice_id: answer_choice.id, user_id: user.id)
#   end
# end

u = User.create!(name: "Ryan Chong")
Poll.first.questions.each do |question|
  question_choice = question.answer_choices[rand(0..3)]
  Response.create!(answer_choice_id: question_choice.id, user_id: u.id)
end

(10..20).each do |user_id|
  user = User.find(user_id)
  Question.all.each do |question|
    next if question.poll.author_id == user_id
    next if rand(20) > 15
    choice = question.answer_choices[rand(0..3)]
    Response.create!(answer_choice_id: choice.id, user_id: user.id)
  end
end
