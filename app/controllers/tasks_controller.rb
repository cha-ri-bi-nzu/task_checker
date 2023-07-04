class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_url, only: %i[new create edit update]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.build(task_params)
    if @task.save
      redirect_to @url, notice: "登録完了しました"
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
      redirect_to @url, notice: "更新完了しました"
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def task_params
    params.require(:Task).permit(:title, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_url
    @url = request.referer
  end
end
