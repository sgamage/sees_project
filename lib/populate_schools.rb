#require 'csv'
#require 'school'
#
#CSV.foreach("schools.csv") do |row|
#  #Ex: ["123", "school name", "principal@email.com"]
#  school = School.new
#  school.name = raw[0]
#  user = User.find_by_email(raw[10])
#  if user
#    user
#  else
#     user = User.new(:email => raw[10], :password => '<password>', :password_confirmation => '<password>' )
#     if user.valid?
#       user.save
#     end   
#  end
#  school.principal_title = raw[1]
#  school.principal_first_name = raw[2]
#  school.principal_surname = raw[3]
#  school.position = raw[4]
#  school.address = raw[5]
#  school.suburb = raw[6]
#  school.state = raw[7]
#  school.postcode = raw[8]
#  school.phone = raw[9]
#  school.email = raw[10]
#  school.category = raw[11] 
#   
#  school.save
#end





#Sameera Code
#
#
#lib/tasks/import.rake
#desc "Imports a CSV file into an ActiveRecord table"
#task :csv_model_import, :filename, :model, :needs => :environment do |task,args|
#  lines = File.new(args[:filename]).readlines
#  header = lines.shift.strip
#  keys = header.split(',')
#  lines.each do |line|
#    params = {}
#    values = line.strip.split(',')
#    keys.each_with_index do |key,i|
#      params[key] = values[i]
#    end
#    Module.const_get(args[:model]).create(params)
#  end
#end
require "#{Rails.root}/app/models/school"

desc "loading CSV file"
task :load_csv => :environment do
   p School.all.first
   puts "Hello world"
end