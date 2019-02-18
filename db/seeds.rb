# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

4.times.each do |i|
  Task.create(
    title: 'something to do' + i.to_s,
    description: 'This is the description of this task. Please read me.',
    completed: false
  )
end
