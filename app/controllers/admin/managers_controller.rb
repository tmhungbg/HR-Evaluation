class Admin::ManagersController < AdminController
   def new
    @manager = Manager.new
  end

  def index
    @managers = Manager.where(active: true).order(email: :asc)
  end

  def create
    @manager = Manager.new(manager_params)
    if @manager.save
      redirect_to admin_managers_path
    else
      render 'new'
    end
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def update
    @manager = Manager.find(params[:id])
    if @manager.update(manager_params)
      redirect_to admin_managers_path
    else
      render 'edit'
    end
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.update(active: false)
    redirect_to admin_managers_path
  end

  def generate_password_all
    Manager.generate_password_all!
    redirect_to admin_managers_path
  end

  def generate_password
    Manager.find(params[:id]).generate_password!
    redirect_to admin_managers_path
  end

  private
    def manager_params
      params.require(:manager).permit(:email, :name, :job)
    end
end