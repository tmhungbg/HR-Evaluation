# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)
admins = [
  {email:"nam@mmj.vn", password:"123456"}
]
staffs = [
  {name: "tran minh hung",    email:"hung@mmj.vn",  job:"developer",       date_start_work: Faker::Date.between(2.years.ago, 6.months.ago) }, 
  {name: "nguyen tat nam",    email:"nam@mmj.vn",   job:"developer",       date_start_work: Faker::Date.between(2.years.ago, 6.months.ago)},
  {name: "nguyen xuan thanh", email:"thanh@mmj.vn", job:"developer",       date_start_work: Faker::Date.between(2.years.ago, 6.months.ago)},
  {name: "nguyen tien manh",  email:"manh@mmj.vn",  job:"developer",       date_start_work: Faker::Date.between(2.years.ago, 6.months.ago)},
  {name: "bui ha",            email:"ha@mmj.vn",    job:"sales_marketing", date_start_work: Faker::Date.between(2.years.ago, 6.months.ago)},
  {name: "nguyen khanh ha",   email:"ha2@mmj.vn",   job:"developer",       date_start_work: Faker::Date.between(2.years.ago, 6.months.ago)},
  {name: "tran duy duong",    email:"duong@mmj.vn", job:"developer",       date_start_work: Faker::Date.between(2.years.ago, 6.months.ago)},
  {name: "tran trung nghia",  email:"nghia@mmj.vn", job:"developer",       date_start_work: Faker::Date.between(2.years.ago, 6.months.ago)},
]
managers = [
  {name: "nguyen ngoc tuan", email:"tuan@mmj.vn", job:"manager"},
  {name: "imamura",          email:"ima@mmj.vn",  job:"manager"},
  {name: "nguyen thi thu",   email:"thu@mmj.vn",  job:"admin"}
]

question_groups = [
  {name: 'PROFESSIONAL WORKING ATTITUDE'},
  {name: 'TEAM WORK SKILLS'},
  {name: 'INTERPERSONAL SKILLS'},
  {name: 'TIME MANAGEMENT SKILLS'},
  {name: 'DEVELOPING OTHERS SKILLS'},
  {name: 'MANAGING P ERFORMANCE SKILLS'}
]
QuestionGroup.create!(question_groups)

Admin.create!(admins)
Staff.create!(staffs)
Manager.create!(managers)
periods = [
  {start_time: "2016-08-03", end_time: "2016-10-10", phase: "phase_5", staff_ids: Staff.limit(2).pluck(:id)},
  {start_time: "2015-08-03", end_time: "2015-08-10", phase: "phase_6", staff_ids: Staff.all.pluck(:id)}
]
Period.create!(periods)

questions = [
  {name: 'This person understands the Company Rules, Policies and tries to comply with the Rule.',                                 question_group: QuestionGroup.first},
  {name: 'This person respects and follows the decision of the managers.',                                                         question_group: QuestionGroup.first},
  {name: 'This person is always responsible for the tasks assigned to himself/herself',                                            question_group: QuestionGroup.first},
  {name: 'This person comes to work with positive and "can do" attitude',                                                          question_group: QuestionGroup.first},
  {name: 'This person acts as an active team member in projects or works that requires working with others.',                      question_group: QuestionGroup.find(2)},
  {name: 'This person listens and responses constructively to other team members\' ideas',                                         question_group: QuestionGroup.find(2)},
  {name: 'This person expresses disagreement construtively.',                                                                      question_group: QuestionGroup.find(2)},
  {name: 'This person is willing to share knowledge and information with others',                                                  question_group: QuestionGroup.find(2)},
  {name: 'This person communicates information and ideas honestly and in a constructive way.',                                     question_group: QuestionGroup.find(3)},
  {name: 'This person communicates effectively and in a logical sequence to ensure that the sent out message is well understood.', question_group: QuestionGroup.find(3)},
  {name: 'This person uses appropriate non-verbal communication when communicating with others.',                                  question_group: QuestionGroup.find(3)},
  {name: 'This person is friendly, respectful and comfortable to work will all people in the company.',                            question_group: QuestionGroup.find(3)},
  {name: 'This person understands the important level of the tasks and is able to priotize the tasks by importance and deadline.', question_group: QuestionGroup.find(4)},
  {name: 'This person attends in all meetings and schedule as requirements.',                                                      question_group: QuestionGroup.find(4)},
  {name: 'This person in on time for works and all occasions at work.',                                                            question_group: QuestionGroup.find(4)},
  {name: 'This person always commits to the deadlines.',                                                                           question_group: QuestionGroup.find(4)},
  {name: 'This person works with staffs to identify areas for development and improvement.',                                       question_group: QuestionGroup.find(5)},
  {name: 'This person provides effective coaching to other members.',                                                              question_group: QuestionGroup.find(5)},
  {name: 'This person motivates staffs to reach the goals and objectives.',                                                        question_group: QuestionGroup.find(5)},
  {name: 'This person works and guides me to set the goals for the works and career development of his/ her subordinate(s).',      question_group: QuestionGroup.find(6)},
  {name: 'This person always gives clarify expectations about the results that he/ she expects from the subordinates.',            question_group: QuestionGroup.find(6)},
  {name: 'This person has the fair and correct feeback and evaluation on the performance of the subordinates.',                    question_group: QuestionGroup.find(6)},
]

Question.create!(questions)

period = Period.phase_6.first
staffs = period.staffs
staff_ids = staffs.pluck(:id)
staffs.each do |staff|
  peer_selection = PeerSelection.create!(staff: staff, period: period, reviewer_ids: (staff_ids - [staff.id]).sample(3))
  peer_evaluations = peer_selection.reload.peer_evaluations
  self_evaluation = SelfEvaluation.create!(staff: staff, period: period)
  manager_evaluation = ManagerEvaluation.create!(staff: staff, period: period)

  peer_evaluations.map(&:initialize_evaluation_answers)
  self_evaluation.initialize_evaluation_answers
  manager_evaluation.initialize_evaluation_answers

  # Update point  
  self_evaluation.rel_evaluation_answers.each do |answer|
    answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
  end
  peer_evaluations.each do |peer_e|
    peer_e.rel_evaluation_answers.each do |answer|
      answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
    end
  end
  manager_evaluation.rel_evaluation_answers.each do |answer|
    answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
  end

  # Update status
  self_evaluation.update!(status: :evaluated)
  peer_evaluations.each{|peer_e| peer_e.update!(status: :evaluated)}
  manager_evaluation.update!(status: :evaluated)
end
EvaluationResult.update_scores(period)


period = Period.phase_5.first
staffs = period.staffs
staff_ids = staffs.pluck(:id)
staffs.each do |staff|
  peer_selection = PeerSelection.create!(staff: staff, period: period, reviewer_ids: (staff_ids - [staff.id]).sample(3))
  peer_evaluations = peer_selection.reload.peer_evaluations
  self_evaluation = SelfEvaluation.create!(staff: staff, period: period)
  manager_evaluation = ManagerEvaluation.create!(staff: staff, period: period)

  peer_evaluations.map(&:initialize_evaluation_answers)
  self_evaluation.initialize_evaluation_answers
  manager_evaluation.initialize_evaluation_answers

  # Update point  
  self_evaluation.rel_evaluation_answers.each do |answer|
    answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
  end
  peer_evaluations.each do |peer_e|
    peer_e.rel_evaluation_answers.each do |answer|
      answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
    end
  end
  manager_evaluation.rel_evaluation_answers.each do |answer|
    answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
  end

  # Update status
  self_evaluation.update!(status: :evaluated)
  peer_evaluations.each{|peer_e| peer_e.update!(status: :evaluated)}
  manager_evaluation.update!(status: :evaluated)
end
EvaluationResult.update_scores(period)