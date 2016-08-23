class Admin::EvaluationWeightsController < AdminController
  def edit
    @evaluation_weight = EvaluationWeight.find(params[:id])
  end

  def update
    @evaluation_weight = EvaluationWeight.find(params[:id])
    if @evaluation_weight.update(evaluation_weight_params)
      flash[:success] = "Updated evaluation weight"
      redirect_to admin_root_path
    else
      flash[:danger] = 'Please check error below'
      render 'edit'
    end
  end

  private

  def evaluation_weight_params
    params.require(:evaluation_weight).permit(
      :normal_self,
      :normal_peer,
      :normal_manager,
      :normal_supervisor,
      :without_peer_self,
      :without_peer_manager,
      :without_peer_supervisor,
      :without_super_self,
      :without_super_manager,
      :without_super_peer,
      :without_peer_and_super_self,
      :without_peer_and_super_manager
    )
  end
end