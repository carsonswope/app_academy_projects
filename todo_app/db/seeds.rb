# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

todo1 = Todo.create!(title: "walk a dog", body: "the dog sure needs walked", done: false)
todo2 = Todo.create(title: "eat a baby", body: "the baby sure needs eaten", done: true)
todo3 = Todo.create(title: "hack the internet", body: "the internet sure rocks", done: true)
