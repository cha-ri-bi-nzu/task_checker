class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = current_user.tasks.includes(:user).create_new_sort
    if params[:time_limit_sort]
      @tasks = @tasks.time_limit_sort
    elsif params[:high_priority_sort]
      @tasks = @tasks.high_priority_sort
    end
    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        @tasks = @tasks.status_select(params[:task][:status])
        @tasks = @tasks.name_select(params[:task][:name])
      elsif params[:task][:status].present?
        @tasks = @tasks.status_select(params[:task][:status])
      elsif params[:task][:name].present?
        @tasks = @tasks.name_select(params[:task][:name])
      end
    end
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "登録完了しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "更新完了しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:name, :time_limit, :status, :priority, :content, label_ids: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
