class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @name = name
    @album = album
    @albu = album
  end

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
      DB[:conn].execute(sql)
  end

  def save
  sql = <<-SQL
    INSERT INTO songs (name, album)
    VALUES (?, ?)
  SQL
  DB[:conn].execute(sql, self.name, self.album)

    # get the song ID from the database and save it to the Ruby instance
  self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

  # return the Ruby instance
  self
  end

  # Here, we use keyword arguments to pass a name and album into our .create method. We use that name and album to instantiate a new song. Then, we use the #save method to persist that song to the database.
  def self.create(name:, album:)
  song = Song.new(name: name, album: album)
  song.save
  end
  
end
