class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  # before_action :set_url, only: %i[new create edit update]

  def index
    @tasks = Task.all.order(created_at: :desc)
    if params[:create_new_sort]
      @tasks = Task.create_new_sort
    elsif params[:time_limit_sort]
      @tasks = Task.time_limit_sort
    elsif params[:high_priority_sort]
      @tasks = Task.high_priority_sort
    end
    # binding.pry
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
    @tasks10 = Task.all.page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
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
    params.require(:task).permit(:name, :time_limit, :status, :priority, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  # def set_url
  #   @url = request.referer
  # end
end
