module ResultHelper
  def self_evaluation_point(question, self_answers)
    self_answers.find{|a| a.question_id == question.id }[:point].to_i
  end

  def peer_evaluation_point(question, peer_answers)
    points = peer_answers.select{|a| a.question_id == question.id }.map{ |a| a[:point].to_i }
    return 0 if points.blank?
    (points.sum.to_f / points.length).round(1)
  end

  def manager_evaluation_point(question, manager_answers)
     manager_answers.find{|a| a.question_id == question.id }[:point].to_i
  end

  def diff_point_display(diff)
    diff = diff.round(1) if diff.is_a?(Float)
    if diff >= 1
      content_tag :strong, diff, class: 'text-primary'
    elsif diff <= -1
      content_tag :strong, diff, class: 'text-danger'
    else
      content_tag :span, diff
    end
  end
end