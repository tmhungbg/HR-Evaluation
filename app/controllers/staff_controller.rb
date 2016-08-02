class StaffController < ApplicationController
  before_action :authenticate_staff!
end
