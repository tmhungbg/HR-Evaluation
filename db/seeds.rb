# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admins = [
  {email:"nam@mmj.vn", password:"123456"}
]
staffs = [
  {name: "tran minh hung", email:"hung@mmj.vn", job:"developer"}, 
  {name: "nguyen tat nam", email:"nam@mmj.vn", job:"developer"},
  {name: "nguyen xuan thanh", email:"thanh@mmj.vn", job:"developer"},
  {name: "nguyen tien manh", email:"manh@mmj.vn", job:"developer"},
  {name: "bui ha", email:"ha@mmj.vn", job:"sales_marketing"},
  {name: "nguyen khanh ha", email:"ha2@mmj.vn", job:"developer"},
  {name: "tran duy duong", email:"duong@mmj.vn", job:"developer"},
  {name: "tran trung nghia", email:"nghia@mmj.vn", job:"developer"},
]
managers = [
  {name: "nguyen ngoc tuan", email:"tuan@mmj.vn", job:"manager"},
  {name: "imamura", email:"ima@mmj.vn", job:"manager"},
  {name: "nguyen thi thu", email:"thu@mmj.vn", job:"admin"}
]
Admin.create!(admins)
Staff.create!(staffs)
Manager.create!(managers)
periods = [
  {start_time: "2016-08-03", end_time: "2016-10-10", phase: "phase_1", staff_ids: Staff.all.pluck(:id)},
  {start_time: "2014-08-03", end_time: "2014-08-10", phase: "phase_6", staff_ids: Staff.all.pluck(:id)},
  {start_time: "2015-08-03", end_time: "2015-08-10", phase: "phase_6"},
  {start_time: "2017-08-03", end_time: "2017-08-10", phase: nil}
]
Period.create!(periods)