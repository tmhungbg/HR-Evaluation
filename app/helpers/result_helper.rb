module ResultHelper
  def self_evaluation_point(question, self_answers)
    answer = self_answers.find{|a| a.question_id == question.id }
    answer[:point].to_i > 0 ? answer[:point] : answer.point_i18n
  end

  def supervisor_evaluation_point(question, supervisor_answers)
    answer = supervisor_answers.find{|a| a.question_id == question.id }
    answer[:point].to_i > 0 ? answer[:point] : answer.point_i18n
  end

  def peer_evaluation_point(question, peer_answers)
    points = peer_answers.select{|a| a.question_id == question.id && a[:point].to_i > 0 }
                         .map{ |a| a[:point].to_i }
    return 'Can not evaluate' if points.blank?
    (points.sum.to_f / points.length).round(1)
  end

  def peer_detail_for_admin(question, peer_answers)
    answers = peer_answers.select{|a| a.question_id == question.id}
    content_tag :div do
      answers.each do |answer|
        result = "#{answer.evaluation.reviewer.name} - #{answer[:point].to_i > 0 ? answer[:point] : answer.point_i18n} - #{answer.comment}\n"
        concat(content_tag :p, result)
      end
    end
  end

  def peer_detail_for_staff(question, peer_answers)
    answers = peer_answers.select{|a| a.question_id == question.id}
    content_tag :div do
      answers.each do |answer|
        result = "#{answer[:point].to_i > 0 ? answer[:point] : answer.point_i18n} - #{answer.comment}\n"
        concat(content_tag :p, result)
      end
    end
  end

  def manager_evaluation_point(question, manager_answers)
     manager_answers.find{|a| a.question_id == question.id }[:point].to_i
  end

  def diff_point_display(other_point, self_point)
    return if other_point.is_a?(String) || self_point.is_a?(String)
    diff = other_point - self_point
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