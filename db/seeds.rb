# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

WorkShift.create name: 'Morning', description: 'Morning shift from 7:00 to 15:00', duration: 8, start_time: '7:00', end_time: '15:00'
WorkShift.create name: 'Evening', description: 'Evening shift from 14:00 to 22:00', duration: 8, start_time: '14:00', end_time: '22:00'