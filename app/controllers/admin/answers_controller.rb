class Admin::AnswersController < AdminController

  def new
    @answer = Answer.new
  end

  def index
    @answers = Answer.all
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to admin_answers_path
    else
      render 'new'
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to admin_answers_path
    else
      render 'edit'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.delete
    redirect_to admin_answers_path
  end

  private
    def answer_params
      params.require(:answer).permit(:answer, :order)
    end
end