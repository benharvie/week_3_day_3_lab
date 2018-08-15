require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')

# Artist.delete_all()
# Album.delete_all()

artist1 = Artist.new({'name' => 'Skrillex'})
artist2 = Artist.new({'name' => 'Flux'})
artist3 = Artist.new({'name' => 'Doctor'})
artist1.save
artist2.save
artist3.save

album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'Bangarang',
  'genre' => 'Dubstep'
})

album2 = Album.new({
  'artist_id' => artist2.id,
  'title' => 'Bass Cannon',
  'genre' => 'Dubstep'
})

album3 = Album.new({
  'artist_id' => artist3.id,
  'title' => 'WobWob',
  'genre' => 'Dubstep'
})

album4 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'Monsters & Nice Sprites',
  'genre' => 'Dubstep'
})

album1.save
album2.save
album3.save
album4.save

binding.pry
nil
