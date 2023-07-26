# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

15.times do |n|
  User.create!(
      name: "adminmin#{n}",
      email: "#{n}@email.com",
      password: "#{n}aaaaaa",
      admin: true
  )
end

15.times do |n|
  Task.create!(name: "sample_task#{n+1}",
              content: "#{n+1}番目のサンプルタスク",
              user_id: 1
              )
end

10.times do |n|
  Label.create!(id: n+1,
                name: "label#{n+1}#{n+1}"
                )
end
