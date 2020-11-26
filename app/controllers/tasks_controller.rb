class TasksController < ApplicationController

  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end


  def show
  end


  def new
    @task = current_user.tasks.new
  end


  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスクを作成しました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクを作成できませんでした'
      render :new
    end
  end


  def edit
  end


  def update
    if @task.update(task_params)
      flash[:success] = 'タスクを更新しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクを更新できませんでした'
      render :edit
    end
  end


  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました'
    redirect_to root_url
  end


  private

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end
