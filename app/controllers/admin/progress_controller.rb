class Admin::ProgressController < AdminController
  def index
    @staffs = current_period.staffs
  end
end