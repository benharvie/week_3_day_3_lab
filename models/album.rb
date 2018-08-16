require_relative('../db/sql_runner.rb')
require_relative('../models/album.rb')

class Album
  attr_accessor :title, :genre
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i if options['artist_id']
  end

  def artists
    sql = "SELECT * FROM artists
    WHERE
    id = $1"
    values = [@artist_id]
    SqlRunner.run(sql, values).map { |artist_hash| Artist.new(artist_hash) }
  end

  def save
    sql = "INSERT INTO albums
    (title, genre, artist_id)
    VALUES
    ($1, $2, $3)
    RETURNING *"
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update #EXTENSTION
    sql = "UPDATE albums SET
    title = $1
    WHERE
    id = $2"
    values = [@title, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM albums
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Album.all
    sql = "SELECT * FROM albums"
    SqlRunner.run(sql).map { |album| Album.new(album) }
  end

  def Album.find(id) #EXTENSTION
    sql = "SELECT * FROM albums
    WHERE
    id = $1"
    values = [id]
    SqlRunner.run(sql, values).map { |album| Album.new(album) }
  end

  def Album.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end
end
