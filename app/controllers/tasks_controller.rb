class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end


  def show
    @task = Task.find(params[:id])
  end


  def new
    @task = Task.new
  end


  def create
    @task = Task.new(message_params)

    if @task.save
      flash[:success] = 'タスクを作成しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクを作成できませんでした'
      render :new
    end
  end
# Strong Parameter
  def message_params
    params.require(:task).permit(:content)
  end


  def edit
    @task = Task.find(params[:id])
  end


  def update
    @task = Task.find(params[:id])

    if @task.update(message_params)
      flash[:success] = 'タスクを更新しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクを更新できませんでした'
      render :edit
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスクを削除しました'
    redirect_to tasks_url
  end

end
