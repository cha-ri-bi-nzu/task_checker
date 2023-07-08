require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[name]", with: 'task_name'
        fill_in "task[content]", with: 'content_1'
        click_button "登録"
        expect('task_name').to have_content 'name'
        expect('content_1').to have_content 'content'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task, name: 'name', content: 'content')
        visit tasks_path
        expect(page).to have_content 'name'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, id: 1, name: 'name1', content: 'content4', created_at: Time.current + 1.day)
        FactoryBot.create(:task, id: 2, name: 'name2', content: 'content8', created_at: Time.current + 2.day)
        FactoryBot.create(:task, id: 3, name: 'name5', content: 'content4', created_at: Time.current + 3.day)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list.first).to have_content "name5"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        FactoryBot.create(:task, name: 'name', content: 'content')
        visit tasks_path
        click_link "詳細"
        expect(page).to have_content 'name'
      end
    end
  end
end
