module ResultHelper
  def self_evaluation_point(question, self_answers)
    self_answers.find{|a| a.question_id == question.id }[:point].to_i
  end

  def peer_evaluation_point(question, peer_answers)
    points = peer_answers.select{|a| a.question_id == question.id }.map{ |a| a[:point].to_i }
    return 0 if points.blank?
    points.sum.to_f / points.length
  end

  def manager_evaluation_point(question, manager_answers)
     manager_answers.find{|a| a.question_id == question.id }[:point].to_i
  end

  def diff_point_display(diff)
    if diff.abs >= 1
      content_tag :strong, diff, class: 'text-danger'
    else
      content_tag :span, diff
    end
  end

  def final_score(self_answers, peer_answers, manager_answers)
    return if self_answers.blank? || peer_answers.blank? || manager_answers.blank?
    sefl_avarage = self_answers.map{|a| a[:point].to_i }.sum.to_f / self_answers.length
    peer_avarage = peer_answers.map{|a| a[:point].to_i }.sum.to_f / peer_answers.length
    manager_avarage = manager_answers.map{|a| a[:point].to_i }.sum.to_f / manager_answers.length
    (0.3 * sefl_avarage + 0.2 * peer_avarage + 0.5 * manager_avarage).round(1)
  end
end