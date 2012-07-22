require 'csv'
require "#{Rails.root}/app/models/school"

desc "loading CSV file"
task :load_csv => :environment do
#   p School.all.first
#   puts "Hello world"

  CSV.foreach("#{Rails.root}/lib/schools.csv") do |row|
  school = School.new
  school.name = row[0]
  
  user = User.find_by_email(row[10])
  if user
    user
  else
     user = User.new(:email => row[10], :password => 'welcome', :password_confirmation => 'welcome' )
     if user.valid?
       user.save
     end   
  end
  school.principal_title = row[1]
  school.principal_firstname = row[2]
  school.principal_surname = row[3]
  school.position = row[4]
  school.address = row[5]
  school.suburb = row[6]
  school.state = row[7]
  school.postcode = row[8]
  school.phone = row[9]
  school.email = row[10]
  school.category = row[11] 
  school.user_id = user.id 
  if school.name.length > 0
    school.save
  end
  end
end