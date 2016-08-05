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
end
