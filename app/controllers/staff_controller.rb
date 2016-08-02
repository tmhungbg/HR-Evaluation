class StaffController < ApplicationController
  before_action :authenticate_staff!

  protected 

  def authenticate_staff!
    super
    if staff_signed_in? &&  ! current_staff.valid_staff?
      flash[:notice] = "You are disabled or there is no active period."
      sign_out :staff
      redirect_to new_staff_session_path
    end
  end
end
