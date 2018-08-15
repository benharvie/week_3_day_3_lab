require_relative('../db/sql_runner.rb')
require_relative('../models/album.rb')

class Artist
  attr_reader :id
  attr_accessor :name
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def albums
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map { |album_hash| Album.new(album_hash) }
  end

  def save
    sql = "INSERT INTO artists
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  # def update #EXTENSTION
  #   sql = "UPDATE artists
  #   SET
  #   (
  #   name
  #   ) =
  #   (
  #   $1
  #   )
  #   WHERE id = $2"
  #   values = [@name, @id]
  #   SqlRunner.run(sql, values)
  # end

  def delete
    sql = "DELETE FROM artists
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Artist.all
    sql = "SELECT * FROM artists"
    return SqlRunner.run(sql).map { |artist| Artist.new(artist) }
  end

  def Artist.find(id) #EXTENSTION
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [id]
    return SqlRunner.run(sql, values).map { |artist| Artist.new(artist) }
  end

  def Artist.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end
end
