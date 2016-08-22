admins = [
  {email:"thu@mmj.vn", password:"123456"}
]
staffs = [
  {name: "Imamura Tomokazu",    email:"ima@mmj.vn",     job:"manager",         is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Nguyen Minh Luan",    email:"minhluan@mmj.vn",job:"manager",         is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Nguyen Ngoc Tuan",    email:"tuan@mmj.vn",    job:"manager",         is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Nguyen Hong Thu",     email:"thu@mmj.vn",     job:"manager",         is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Pham Thi Hong Hanh",  email:"hanh@mmj.vn",    job:"manager",         is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Le Viet Ha",          email:"vietha@mmj.vn",  job:"manager",         is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Tomoya Endo",         email:"tendo@mmj.ne.jp",job:"tester",          is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Nguyen Van Hao",      email:"hao@mmj.vn",     job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Le Ha Minh",          email:"minh@mmj.vn",    job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Le Bao Quoc",         email:"quoc@mmj.vn",    job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Tran Minh Hung",      email:"hung@mmj.vn",    job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Vu Xuan Thanh",       email:"thanh@mmj.vn",   job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 1},
  {name: "Tran Duy Duong",      email:"duong@mmj.vn",   job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 2},
  {name: "Nguyen Tien Manh",    email:"manh@mmj.vn",    job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 2},
  {name: "Nguyen Tat Nam",      email:"nam@mmj.vn",     job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 2},
  {name: "Nguyen Kim Quy",      email:"quy@mmj.vn",     job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 3},
  {name: "Dang Manh Cuong",     email:"cuong@mmj.vn",   job:"designer",        is_supervisor: false, is_senior: false, supervisor_id: 3},
  {name: "Bui Anh Ha",          email:"buiha@mmj.vn",   job:"sales_marketing", is_supervisor: false, is_senior: false, supervisor_id: 3},
  {name: "Le Duc Hoang Anh",    email:"hoanganh@mmj.vn",job:"sales_marketing", is_supervisor: false, is_senior: false, supervisor_id: 3},
  {name: "Nguyen Thuy Linh",    email:"thuylinh@mmj.vn",job:"sales_marketing", is_supervisor: false, is_senior: false, supervisor_id: 3},
  {name: "Le Phuong Thao",      email:"thao@mmj.vn",    job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 4},
  {name: "Dao Thi Thanh Hue",   email:"hue@mmj.vn",     job:"developer",       is_supervisor: false, is_senior: false, supervisor_id: 4},
  {name: "Le Thi Thuy Luan",    email:"thuyluan@mmj.vn",job:"tester",          is_supervisor: false, is_senior: false, supervisor_id: 5},
  {name: "Hoang Thi Khanh Ngoc",email:"ngoc@mmj.vn",    job:"tester",          is_supervisor: false, is_senior: false, supervisor_id: 5},
  {name: "Tran Hai Yen",        email:"yen@mmj.vn",     job:"tester",          is_supervisor: false, is_senior: false, supervisor_id: 5},
  {name: "Ngo Duy Thuy Nuong",  email:"nuong@mmj.vn",   job:"tester",          is_supervisor: false, is_senior: false, supervisor_id: 5},
  {name: "Trinh Thi Hien",      email:"hien@mmj.vn",    job:"tester",          is_supervisor: false, is_senior: false, supervisor_id: 5},
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

p 'Create question group'
QuestionGroup.create!(question_groups)

p 'Create Admin'
Admin.create!(admins)

p 'Create staffs'
Staff.create!(staffs)

p 'Create manager'
Manager.create!(managers)
periods = [
  {start_time: "2015-08-03", end_time: "2015-08-10", phase: "phase_6", staff_ids: Staff.all.pluck(:id)},
  {start_time: "2016-08-03", end_time: "2016-10-10", staff_ids: Staff.all.pluck(:id)},
]

p 'Create period'
Period.create!(periods)

questions = [
  {
    short_description: 'Company Rules, Policies',
    name: 'This person understands the Company Rules, Policies and tries to comply with the Rule.',
    question_group: QuestionGroup.first
  },
  {
    short_description: 'Decision of the managers',
    name: 'This person respects and follows the decision of the managers.',
    question_group: QuestionGroup.first
  },
  {
    short_description: 'Responsible for the tasks',
    name: 'This person is always responsible for the tasks assigned to himself/herself',
    question_group: QuestionGroup.first
  },
  {
    short_description: 'Positive and "can do" attitude',
    name: 'This person comes to work with positive and "can do" attitude',
    question_group: QuestionGroup.first
  },
  {
    short_description: 'Active team member',
    name: 'This person acts as an active team member in projects or works that requires working with others.',
    question_group: QuestionGroup.find(2)
  },
  {
    short_description: 'Listens and responses constructively' ,
    name: 'This person listens and responses constructively to other team members\' ideas',
    question_group: QuestionGroup.find(2)
  },
  {
    short_description: 'Disagreement construtively',
    name: 'This person expresses disagreement construtively.',
    question_group: QuestionGroup.find(2)
  },
  {
    short_description: 'Share knowledge and information',
    name: 'This person is willing to share knowledge and information with others',
    question_group: QuestionGroup.find(2)
  },
  {
    short_description: 'Communicates information and ideas honestly',
    name: 'This person communicates information and ideas honestly and in a constructive way.',
    question_group: QuestionGroup.find(3)
  },
  {
    short_description: 'Communicates effectively and in a logical sequence',
    name: 'This person communicates effectively and in a logical sequence to ensure that the sent out message is well understood.',
    question_group: QuestionGroup.find(3)
  },
  {
    short_description: 'Appropriate non-verbal communication',
    name: 'This person uses appropriate non-verbal communication when communicating with others.',
    question_group: QuestionGroup.find(3)
  },
  {
    short_description: 'Friendly, respectful and comfortable',
    name: 'This person is friendly, respectful and comfortable to work will all people in the company.',
    question_group: QuestionGroup.find(3)
  },
  {
    short_description: 'Understands the important level of the tasks',
    name: 'This person understands the important level of the tasks and is able to priotize the tasks by importance and deadline.',
    question_group: QuestionGroup.find(4)
  },
  {
    short_description: 'Meetings and schedule as requirements',
    name: 'This person attends in all meetings and schedule as requirements.',
    question_group: QuestionGroup.find(4)
  },
  {
    short_description: 'On time for works',
    name: 'This person in on time for works and all occasions at work.',
    question_group: QuestionGroup.find(4)
  },
  {
    short_description: 'Always commits to the deadlines',
    name: 'This person always commits to the deadlines.',
    question_group: QuestionGroup.find(4)
  },
  {
    short_description: 'Works with staffs to identify areas',
    name: 'This person works with staffs to identify areas for development and improvement.',
    question_group: QuestionGroup.find(5)
  },
  {
    short_description: 'Provides effective coaching to other members',
    name: 'This person provides effective coaching to other members.',
    question_group: QuestionGroup.find(5)
  },
  {
    short_description: 'Motivates staffs',
    name: 'This person motivates staffs to reach the goals and objectives.',
    question_group: QuestionGroup.find(5)
  },
  {
    short_description: 'works and guides me to set the goals',
    name: 'This person works and guides me to set the goals for the works and career development of his/ her subordinate(s).',
    question_group: QuestionGroup.find(6)
  },
  {
    short_description: 'always gives clarify expectation',
    name: 'This person always gives clarify expectations about the results that he/ she expects from the subordinates.',
    question_group: QuestionGroup.find(6)
  },
  {
    short_description: 'the fair and correct feeback',
    name: 'This person has the fair and correct feeback and evaluation on the performance of the subordinates.',
    question_group: QuestionGroup.find(6)
  }
]

p 'Create questions'
Question.create!(questions)


p 'Create data for old period'
period = Period.phase_6.first
staffs = period.staffs
staff_ids = staffs.pluck(:id)
staffs.each do |staff|
  peer_selection = PeerSelection.find_by(staff: staff, period: period)
  peer_selection.update!(reviewer_ids: (staff_ids - [staff.id]).sample(3))
  peer_evaluations      = peer_selection.reload.peer_evaluations
  self_evaluation       = SelfEvaluation.find_by(staff: staff, period: period)
  supervisor_evaluation = SupervisorEvaluation.find_by(staff: staff, period: period)
  manager_evaluation    = ManagerEvaluation.find_by(staff: staff, period: period)

  peer_evaluations.map(&:initialize_evaluation_answers)
  self_evaluation.initialize_evaluation_answers
  supervisor_evaluation.initialize_evaluation_answers
  manager_evaluation.initialize_evaluation_answers

  # Update point
  self_evaluation.rel_evaluation_answers.each do |answer|
    answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
  end
  supervisor_evaluation.rel_evaluation_answers.each do |answer|
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
  supervisor_evaluation.update!(status: :evaluated)
  peer_evaluations.each{|peer_e| peer_e.update!(status: :evaluated)}
  manager_evaluation.update!(status: :evaluated)
end


# p 'Update data for current_period'
# staffs = period.staffs
# staff_ids = staffs.pluck(:id)
# staffs.each do |staff|
#   peer_selection = PeerSelection.find_by(staff: staff, period: period)
#   peer_selection.update!(reviewer_ids: (staff_ids - [staff.id]).sample(3))
#   peer_evaluations      = peer_selection.reload.peer_evaluations
#   self_evaluation       = SelfEvaluation.find_by(staff: staff, period: period)
#   supervisor_evaluation = SupervisorEvaluation.find_by(staff: staff, period: period)
#   manager_evaluation    = ManagerEvaluation.find_by(staff: staff, period: period)

#   peer_evaluations.map(&:initialize_evaluation_answers)
#   self_evaluation.initialize_evaluation_answers
#   supervisor_evaluation.initialize_evaluation_answers
#   manager_evaluation.initialize_evaluation_answers

#   # Update point
#   self_evaluation.rel_evaluation_answers.each do |answer|
#     answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
#   end
#   supervisor_evaluation.rel_evaluation_answers.each do |answer|
#     answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
#   end
#   peer_evaluations.each do |peer_e|
#     peer_e.rel_evaluation_answers.each do |answer|
#       answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
#     end
#   end
#   manager_evaluation.rel_evaluation_answers.each do |answer|
#     answer.update!(point: rand(1..5), comment: Faker::Lorem.sentence )
#   end

#   # Update status
#   self_evaluation.update!(status: :evaluated)
#   supervisor_evaluation.update!(status: :evaluated)
#   peer_evaluations.each{|peer_e| peer_e.update!(status: :evaluated)}
#   manager_evaluation.update!(status: :evaluated)
# end