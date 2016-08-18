class Staff::PeerSelectionsController < StaffController
  def index
    @peer_selection = PeerSelection.find_or_create_by(staff: current_staff, period: current_period)
  end

  def update
    if ! current_period.phase_2?
      flash[:danger] = 'Can not update peer selection in this phase'
      redirect_to staff_root_path
      return
    end
    @peer_selection = PeerSelection.find_by(staff: current_staff, period: current_period)
    if @peer_selection.update(peer_selection_params)
      flash[:success] = 'Updated successfully'
      redirect_to staff_root_path
    else
      flash[:success] = 'Can not update, please check errors below'
      render :index
    end
  end

  private
  
  def peer_selection_params
    params.require(:peer_selection).permit(:reason, reviewer_ids: [])
  end
end