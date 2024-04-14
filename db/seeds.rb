# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
AmusementPark.destroy_all
Ride.destroy_all

@six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
@hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
@scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
@ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
@insane = @six_flags.rides.create!(name: 'Insane-o-Rama', thrill_rating: 10, open: false)

@universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)
@jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
@wild = @universal.rides.create!(name: 'Wild', thrill_rating: 9, open: true)
@crazy = @universal.rides.create!(name: 'Crazy', thrill_rating: 10, open: true)

@dave = Mechanic.create!(name: "Dave Williams", years_experience: 30)
@barbara = Mechanic.create!(name: "Barbara Jones", years_experience: 15)
@kyle = Mechanic.create!(name: "Kyle Smith", years_experience: 22)

MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @dave.id)
MechanicRide.create!(ride_id: @scrambler.id, mechanic_id: @dave.id)
MechanicRide.create!(ride_id: @jaws.id, mechanic_id: @dave.id)
MechanicRide.create!(ride_id: @crazy.id, mechanic_id: @dave.id)

MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @barbara.id)
MechanicRide.create!(ride_id: @ferris.id, mechanic_id: @barbara.id)
MechanicRide.create!(ride_id: @insane.id, mechanic_id: @barbara.id)
MechanicRide.create!(ride_id: @crazy.id, mechanic_id: @barbara.id)

MechanicRide.create!(ride_id: @hurler.id, mechanic_id: @kyle.id)
MechanicRide.create!(ride_id: @insane.id, mechanic_id: @kyle.id)
MechanicRide.create!(ride_id: @wild.id, mechanic_id: @kyle.id)
MechanicRide.create!(ride_id: @crazy.id, mechanic_id: @kyle.id)

puts "Seeded Successfully"