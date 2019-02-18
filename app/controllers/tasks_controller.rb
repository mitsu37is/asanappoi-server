class TasksController < ApplicationController
  def index
    @tasks = Task.all
    render json: @tasks
  end

  def show
  end

  def edit
  end

  def new
  end

  def update
  end

  def create
  end
end
