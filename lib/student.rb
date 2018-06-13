

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  @@all = []

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id

    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.create_table
    sql_syntax_create_table =<<-SQL_SYNTAX
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
    SQL_SYNTAX

    DB[:conn].execute(sql_syntax_create_table)
  end


  def self.drop_table
    sql_syntax_drop_table =<<-SQL_SYNTAX
      DROP TABLE students;
      );
    SQL_SYNTAX

    DB[:conn].execute(sql_syntax_drop_table)
  end

  def save
    sql_syntax_drop_table =<<-SQL_SYNTAX
      INSERT INTO students (name, grade)
      VALUES (?,?);
    SQL_SYNTAX

    DB[:conn].execute(sql_syntax_drop_table, self.name, self.grade)

    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end


end
