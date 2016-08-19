class Manager::PagesController < ManagerController
  def home
    @manager_evaluations = ManagerEvaluation.joins(:staff).where(period: current_period).order('staffs.name')
  end
end