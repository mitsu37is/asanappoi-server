# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      def index
        tasks = Task.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'loaded tasks', data: tasks }
      end

      def show
        task = Task.find(params[:id])
        render json: {
          status: 'SUCCESS',
          message: 'loaded the task',
          data: task
        }
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: {
            status: 'SUCCESS',
            message: 'task saved',
            data: task
          }
        else
          render json: {
            status: 'ERROR',
            message: 'task not saved',
            data: task.errors
          }
        end
      end

      def update
        task = Task.find(params[:id])
        if task.update(task_params)
          render json: {
            status: 'SUCCESS',
            message: 'task updated',
            data: task
          }
        else
          render json: {
            status: 'ERROR',
            message: 'task not updated',
            data: task.errors
          }
        end
      end

      def destroy
        task = Task.find(params[:id])
        task.destroy
        render json: {
          status: 'SUCCESS',
          message: 'deleted the post',
          data: task
        }
      end

      private

      def task_params
        params.require(:task).permit(:title, :description, :completed)
      end
    end
  end
end
