class Manager::ManagerEvaluationsController < ManagerController
  def index
    @staff = Staff.where(active: true).order(email: :asc)
    @manager_evaluation = ManagerEvaluation.by_staff_and_period(current_period)
  end
end