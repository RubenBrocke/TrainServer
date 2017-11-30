require "kemal"
require "db"
require "sqlite3"

db = DB.open "sqlite3://./data.db" 
#Create if not yet created
db.exec("DROP TABLE times")
db.exec("CREATE TABLE times (id string)")
puts "CREATED NEW DATABASE"

begin 
#Showing basic information about the system
get "/" do
  db.query("SELECT * FROM times") do |result|
    size = 0
    result.each do
      size += 1
    end
    size
  end
end

#For adding data to the database using a http request
post "/:id" do |env|
  id = env.params.url["id"]
  db.exec("INSERT INTO times (id) VALUES (?)", id.to_s)
  "Added #{id} to database"
end

Kemal.run

while(true)
{
  input = gets.to_s.chomp
  if (intput == "exit") do
    exit
  end
}

ensure
  db.close
  puts "Closing database"
  Kemal.stop
  puts "Stopping Server"
end
