module AdminsHelper
  def render_period_status(period)
    if period.current_period?
      content_tag :span, 'Active', class: 'label label-success'
    else
      content_tag :span, 'Unactive', class: 'label label-default'
    end
  end

  def render_edit_period_link(period)
    return unless period.can_edit?
    link_to "Edit", edit_admin_period_path(period.id), class: "btn btn-success"
  end

  def render_question_move_up_btn(question)
    # return if question.display_order.to_i == Question.active.pluck(:display_order).min
    # link_to "", move_up_admin_question_path(question), class: "glyphicon glyphicon-arrow-up"
    link_to move_up_admin_question_path(question), class: "btn btn-default" do
      concat content_tag(:span, nil, class: 'glyphicon glyphicon-arrow-up')
      concat ' Up'
    end
  end

  def render_question_move_down_btn(question)
    # return if question.display_order == Question.active.pluck(:display_order).max
    # link_to "", move_down_admin_question_path(question), class: "glyphicon glyphicon-arrow-down"
    link_to move_down_admin_question_path(question), class: "btn btn-default" do 
      concat content_tag(:span, nil, class: 'glyphicon glyphicon-arrow-down')
      concat ' Down'
    end
  end
end
