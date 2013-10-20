# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

herd = Herd.create()
Yak.create(name: 'Yellow Yak', color: '#575501')
Yak.create(name: 'Imperial Yak', color: '#0177A8')

herd.grunts << Grunt.create(message: 'Test Message', yak_id: 1)
herd.grunts << Grunt.create(message: 'Test Message Second', yak_id: 2)
herd.grunts << Grunt.create(message: 'Test Message Third', yak_id: 1)
herd.grunts << Grunt.create(message: 'Test Message Fourth', yak_id: 2)
