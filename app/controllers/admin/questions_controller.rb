class Admin::QuestionsController < AdminController

  def new
    @question = Question.new
    @question.build_answer
  end

  def index
    @questions = Question.preload(:question_group).active.order(display_order: :asc)
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Created question"
      redirect_to admin_questions_path
    else
      render 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = "Updated question"
      redirect_to admin_questions_path
    else
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.update(active: false)
      flash[:success] = "Deleted question"
    else
      flash[:danger] = "Can not delete this question"
    end
    redirect_to admin_questions_path
  end

  def move_up
    @question = Question.find(params[:id])

    if @question.move_order_up
      flash[:success] = "Moved successfully"
    else
      flash[:danger] = "Can not move"
    end

    redirect_to admin_questions_path
  end

  def move_down
    @question = Question.find(params[:id])

    if @question.move_order_down
      flash[:success] = "Moved successfully"
    else
      flash[:danger] = "Can not move"
    end

    redirect_to admin_questions_path
  end

  private

  def question_params
    params.require(:question).permit(
      :question, :question_group_id, 
      answers_attributes: [:id, :name, :point,:display_order]
    )
  end
end