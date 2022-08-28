class Song

  attr_accessor :name, :album
  attr_accessor :name, :album, :id

  def initialize(name:, album:)
  def initialize(name:, album:,id: nil)
    @name = name
    @album = album
    @id=id
  end

  def self.create(name:,album:)
    Song.new(name:name,album:album).save
  end

  def self.create_table
    query=<<-SQL
    CREATE TABLE if NOT EXISTS songs(
      id INTEGER PRIMARY KEY,
      name TEXT,
      album TEXT
    )
    SQL
    DB[:conn].execute(query)
  end

  def save
    query=<<-SQL
    INSERT INTO songs(name,album)
    VALUES (?,?)
    SQL
    DB[:conn].execute(query,self.name,self.album)

    self.id=DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    self
  end
end