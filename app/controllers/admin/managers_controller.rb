class Admin::ManagersController < AdminController
   def new
    @manager = Manager.new
  end

  def index
    @managers = Manager.all
  end

  def create
    @manager = Manager.new(manager_params)
    if @manager.save
      redirect_to admins_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @manager.update(manager_params)
      redirect_to admins_path
    else
      render 'edit'
    end
  end

  def destroy
    @manager.destroy
    redirect_to admins_path
  end

  private
    def manager_params
      params.require(:manager).permit(:email, :encrypted_password)
    end
end