# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create guest user
guest = User.new(
        first_name: 'guest',
        last_name: 'guest'
)
guest.save(validate:false)
guest.roles << Role.find_by_name('guest')