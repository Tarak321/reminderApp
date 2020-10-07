# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
connection = ActiveRecord::Base.connection()
# connection.execute("delete from action_text_rich_texts");
connection.execute("delete from active_storage_attachments");
connection.execute("delete from active_storage_blobs");
# connection.execute("delete from friendly_id_slugs");
connection.close()

MedicalHistory.delete_all 
Dependent.delete_all 
User.delete_all 

user1 = User.create!({
  name: "Tom",
  email_address: "test@test.com",
  email: "test@test.com",
  contact_number: "1234567890",
  country: "India",
  date_of_birth: 20.years.ago,
  blood_group: "b+ve",
  weight: "60",
  height: "145",
  password_digest: BCrypt::Password.create('123456')
})


dep1 = Dependent.create!({
  user_id: user1.id,
  relationship: "Mother",
  name: "Toms mother",
  email_address: "tm@test.com",
  contact_number: "4312567897",
  blood_group: "B+",
  date_of_birth: 50.years.ago,
  weight: "60",
  height: "145"
})

dep2 = Dependent.create!({
  user_id: user1.id,
  relationship: "Father",
  name: "Toms Father",
  email_address: "tf@test.com",
  contact_number: "3312567897",
  blood_group: "A+",
  date_of_birth: 52.years.ago,
  weight: "65",
  height: "155"
})


# MedicalHistory.create!({
#   user: user1,
#   illness: "Fever",
#   drname: "Dr. Strange",
#   medicine: "Paracetomol",
#   startdate: 2.days.ago.to_date,
#   enddate: 10.days.from_now,
#   dosage_amount: "1 dosage",
#   dosage_frequency: "daily-twice",
#   dosage_time: "2pm",
#   email_notify: true
# })

MedicalHistory.create!({
  user: user1,
  illness: "Fever",
  drname: "Dr. Strange",
  medicine: "Paracetomol",
  start_date: 10.days.ago.to_date,
  # enddate: DateTime.now.prev_day.to_date,
  end_date: DateTime.now.to_date,
  dosage_amount: "1 dosage",
  dosage_frequency: "daily-twice",
  dosage_time: "2pm",
  email_notify: true
})

MedicalHistory.create!({
  user: user1,
  illness: "Fever",
  drname: "Dr. Strange",
  medicine: "Crocin",
  start_date: 10.days.ago.to_date,
  # enddate: DateTime.now.prev_day.to_date,
  end_date: DateTime.now.to_date,
  dosage_amount: "1 dosage",
  dosage_frequency: "daily-twice",
  dosage_time: "2pm",
  email_notify: true
})


MedicalHistory.create!({
  user: user1,
  illness: "Fever",
  drname: "Dr. Strange",
  medicine: "Paracetomol",
  start_date: DateTime.now.next.to_date,
  end_date: 4.days.from_now.to_date,
  dosage_amount: "1 dosage",
  dosage_frequency: "daily-twice",
  dosage_time: "2pm",
  email_notify: true
})


MedicalHistory.create!({
  user: user1,
  dependent: dep1,
  relation:"Mother",
  illness: "Cough",
  drname: "Dr. Iron",
  medicine: "Tablet",
  start_date: DateTime.now,
  end_date: 12.days.from_now,
  dosage_amount: "2 dosage",
  dosage_frequency: "daily-twice",
  dosage_time: "1pm",
  email_notify: true
})

MedicalHistory.create!({
  user: user1,
  dependent: dep2,
  relation:"Father",
  illness: "Sore Throat",
  drname: "Dr. Superman",
  medicine: "Syrup",
  start_date: 10.days.ago.to_date,
  end_date: DateTime.now.prev_day.to_date,
  dosage_amount: "2 dosage",
  dosage_frequency: "daily-thrice",
  dosage_time: "2pm",
  email_notify: true
})

MedicalHistory.create!({
  user: user1,
  dependent: dep2,
  relation:"Father",
  illness: "Joint Pain",
  drname: "Dr. Superman",
  medicine: "Iodex",
  start_date: DateTime.now.next.to_date,
  end_date: 4.days.from_now.to_date,
  dosage_amount: "2 dosage",
  dosage_frequency: "daily-thrice",
  dosage_time: "2pm",
  email_notify: true
})