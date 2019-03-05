# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TasksApi', type: :request do
  describe 'tasks' do
    context 'index GET /api/v1/tasks' do
      before do
        FactoryBot.create(:task, title: 'prepare rails api server')
        FactoryBot.create(:task, title: 'call web api through react')
        get '/api/v1/tasks'
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns tasks list' do
        json = JSON.parse(response.body)
        expect(json['data'][0]['title']).to eq('prepare rails api server')
        expect(json['data'][1]['title']).to eq('call web api through react')
      end
    end

    context 'show GET /api/v1/tasks/:id' do
      before do
        @task = FactoryBot.create(:task, title: 'write some test code')
        get "/api/v1/tasks/#{@task.id}"
      end

      it 'returns status 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a task' do
        json = JSON.parse(response.body)
        expect(json['data']['title']).to eq 'write some test code'
      end
    end

    context 'create POST /api/v1/tasks' do
      it 'returns status 200' do
        task_attributes = FactoryBot.attributes_for(:task)
        post '/api/v1/tasks', params: { task: task_attributes }
        expect(response).to have_http_status(200)
      end

      it 'counts up by 1' do
        task_attributes = FactoryBot.attributes_for(:task)
        expect {
          post '/api/v1/tasks', params: { task: task_attributes }
        }.to change(Task.all, :count).by(1)
      end
    end

    context 'update PATCH /api/v1/tasks/:id' do
      before do
        @task = FactoryBot.create(:task)
        task_attributes = FactoryBot.attributes_for(:task, title: 'updated title')
        patch "/api/v1/tasks/#{@task.id}", params: { task: task_attributes }
      end

      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'changes title' do
        expect(@task.reload.title).to eq 'updated title'
      end
    end

    context 'destroy DELETE /api/v1/tasks/:id' do
      before do
        @task = FactoryBot.create(:task)
      end

      it 'deletes a task' do
        expect {
          delete "/api/v1/tasks/#{@task.id}"
        }.to change(Task.all, :count).by(-1)
      end
    end
  end
end
