require_relative "../config/environment.rb"

class Student
  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
      SQL
    DB[:conn].execute(sql)
  end
  
  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.album)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
  end
  
  def self.create(name:, grade:) 
    student = Student.new(name, grade)
    student.save
    student 
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
