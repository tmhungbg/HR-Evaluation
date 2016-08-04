class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    case resource.class.name.downcase.to_sym
    when :admin
      admin_root_path
    when :staff
      staff_root_path
    when :manager
      manager_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      admin_root_path
    when :staff
      staff_root_path
    when :manager
      manager_root_path
    else
      root_path
    end
  end

  def current_period
    @_current_period ||= Period.get_current_period
  end

  helper_method :current_period
end
