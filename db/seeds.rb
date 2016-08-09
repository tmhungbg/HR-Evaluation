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

question_groups = [
  {name: 'PROFESSIONAL WORKING ATTITUDE'},
  {name: 'TEAM WORK SKILLS'},
  {name: 'INTERPERSONAL SKILLS'},
  {name: 'TIME MANAGEMENT SKILLS'},
  {name: 'DEVELOPING OTHERS SKILLS'},
  {name: 'MANAGING PERFORMANCE SKILLS'}
]
QuestionGroup.create!(question_groups)

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

questions = [
  {question: 'This person understands the Company Rules, Policies and tries to comply with the Rule.', question_group: QuestionGroup.first},
  {question: 'This person respects and follows the decision of the managers.', question_group: QuestionGroup.first},
  {question: 'This person is always responsible for the tasks assigned to himself/herself', question_group: QuestionGroup.first},
  {question: 'This person comes to work with positive and "can do" attitude', question_group: QuestionGroup.first},
  {question: 'This person acts as an active team member in projects or works that requires working with others.', question_group: QuestionGroup.find(2)},
  {question: 'This person listens and responses constructively to other team members\' ideas', question_group: QuestionGroup.find(2)},
  {question: 'This person expresses disagreement construtively.', question_group: QuestionGroup.find(2)},
  {question: ' This person is willing to share knowledge and information with others', question_group: QuestionGroup.find(2)},
  {question: 'This person communicates information and ideas honestly and in a constructive way.', question_group: QuestionGroup.find(3)},
  {question: 'This person communicates effectively and in a logical sequence to ensure that the sent out message is well understood.', question_group: QuestionGroup.find(3)},
  {question: 'This person uses appropriate non-verbal communication when communicating with others.', question_group: QuestionGroup.find(3)},
  {question: 'This person is friendly, respectful and comfortable to work will all people in the company.', question_group: QuestionGroup.find(3)},
  {question: 'This person understands the important level of the tasks and is able to priotize the tasks by importance and deadline.', question_group: QuestionGroup.find(4)},
  {question: 'This person attends in all meetings and schedule as requirements.', question_group: QuestionGroup.find(4)},
  {question: 'This person in on time for works and all occasions at work.', question_group: QuestionGroup.find(4)},
  {question: 'This person always commits to the deadlines.', question_group: QuestionGroup.find(4)},
  {question: 'This person works with staffs to identify areas for development and improvement.', question_group: QuestionGroup.find(5)},
  {question: 'This person provides effective coaching to other members.', question_group: QuestionGroup.find(5)},
  {question: 'This person motivates staffs to reach the goals and objectives.', question_group: QuestionGroup.find(5)},
  {question: 'This person works and guides me to set the goals for the works and career development of his/ her subordinate(s).', question_group: QuestionGroup.find(6)},
  {question: 'This person always gives clarify expectations about the results that he/ she expects from the subordinates.', question_group: QuestionGroup.find(6)},
  {question: 'This person has the fair and correct feeback and evaluation on the performance of the subordinates.', question_group: QuestionGroup.find(6)},
]

Question.create!(questions)
