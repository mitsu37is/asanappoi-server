# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TasksApi', type: :request do
  describe 'tasks' do
    it 'show' do
      FactoryBot.create(:task, title: 'loads a task やで')

      # tasks/index へ access する
      get api_v1_tasks_path
      expect(response).to have_http_status(:success)

      # index で取得した json から show で見たい task を選択
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq 1
      task_id = json['data'][0]['id']

      # show で見られるか検証
      get api_v1_task_path(task_id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['data']['title']).to eq 'loads a task やで'
    end

    it 'create' do
    end

    it 'update' do
    end

    it 'destroy' do
    end
  end
end
