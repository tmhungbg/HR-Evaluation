class ManagerController < ApplicationController
  before_action :authenticate_manager!

  protected 

  def authenticate_manager!
    super
    if manager_signed_in? &&  ! current_manager.valid_manager?
      flash[:notice] = "You are disabled or there is no active period."
      sign_out :manager
      redirect_to new_manager_session_path
    end
  end
end
