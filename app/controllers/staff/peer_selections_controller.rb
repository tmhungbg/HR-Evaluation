class Staff::PeerSelectionsController < StaffController
  def index
    @peer_selection = PeerSelection.find_or_create_by(staff: current_staff, period: current_period)
  end

  def update
    @peer_selection = PeerSelection.find_by(staff: current_staff, period: current_period)
    if @peer_selection.update(peer_selection_params)
      redirect_to staff_root_path
    else
      render :index
    end
  end

  private
  
  def peer_selection_params
    params.require(:peer_selection).permit(:reason, reviewer_ids: [])
  end
end


# current_reviewer_ids = peer_selection.reviewer_ids

# new_review_ids = params[:peer_selection][:reviewer_ids]

# Add = new_review_ids - current_reviewer_ids
# Destroy = current_reviewer_ids - new_review_ids

# Add.each => create PeerEvaluation
# Destroy.each => destroy PeerEvaluation