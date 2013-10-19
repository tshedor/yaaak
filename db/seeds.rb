# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

herd = Herd.create()
Yak.create()
Yak.create()
Grunt.create(message: 'Test Message', herd_id: herd.id, yak_id: 1)
Grunt.create(message: 'Test Message Second', herd_id: herd.id, yak_id: 2)
Grunt.create(message: 'Test Message Third', herd_id: herd.id, yak_id: 1)
Grunt.create(message: 'Test Message Fourth', herd_id: herd.id, yak_id: 2)
