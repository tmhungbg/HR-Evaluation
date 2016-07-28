class Admin::StaffsController < AdminController
  def new
    @staff = Staff.new
  end

  def index
    @staffs = Staff.order(email: :asc).all
  end

  def create
    @staff = Staff.new(staff_params)
    if @staff.save
      redirect_to admin_staffs_path
    else
      render 'new'
    end
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])
    if @staff.update(staff_params)
      redirect_to admin_staffs_path
    else
      render 'edit'
    end
  end

  # def destroy
  #   @staff = Staff.find(params[:id])
  #   if 
  #   @staff.destroy
  #   redirect_to admins_path
  # end

  private
    def staff_params
      params.require(:staff).permit(:name, :job, :email, :display_password)
    end
end