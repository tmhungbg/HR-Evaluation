class Admin::StaffsController < AdminController

  def new
    @staff = Staff.new
  end

  def index
    @staffs = Staff.where(active: true).order(email: :asc)
  end

  def create
    @staff = Staff.new(staff_params)
      # binding.pry
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

  def destroy
    @staff = Staff.find(params[:id])
    @staff.update(active: false)
    redirect_to admin_staffs_path
  end

  def generate_password_all
    Staff.generate_password_all!
    redirect_to admin_staffs_path
  end

  def generate_password
    Staff.find(params[:id]).generate_password!
    redirect_to admin_staffs_path
  end

  private
    def staff_params
      params.require(:staff).permit(:name, :job, :email)
    end
end