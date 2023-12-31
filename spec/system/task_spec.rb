require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:user) {FactoryBot.create(:user)}
    before do
      visit new_session_path
      fill_in "session_email", with: '1ban@mail.com'
      fill_in "session[password]", with: 'aaaaaa'
      click_button "Log in"
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        # sleep(1)
        fill_in "task_name", with: 'task_name'
        fill_in "task_content", with: 'content_1'
        fill_in "task_time_limit", with: '2023-07-18T10:30'
        click_button "登録"
        # binding.pry
        expect(page).to have_content 'task_name'
        expect(page).to have_content '未着手'
        expect(page).to have_content '07/18 10:30'
        expect(page).to have_content '高'
        expect(page).to have_content 'user_name1'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:user) {FactoryBot.create(:user)}
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) {FactoryBot.create(:task, name: "task", content: 'content4', created_at: Time.current + 1.day, user: user)}
    let!(:second_task) {FactoryBot.create(:task, name: "sample", content: 'content8', created_at: Time.current + 2.day, user: user)}
    let!(:third_task) {FactoryBot.create(:task, name: "name5", content: 'content4', created_at: Time.current + 3.day, user: user)}
    before do
      visit new_session_path
      fill_in "session_email", with: '1ban@mail.com'
      fill_in "session[password]", with: 'aaaaaa'
      click_button "Log in"
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'name5'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list_f = first('.spec_test_name')
        expect(task_list_f).to have_content "name5"
      end
    end
  end
  describe 'ソート機能' do
    let!(:user) {FactoryBot.create(:user)}
    let!(:task) {FactoryBot.create(:task, name: "task_name1", time_limit: Time.current + 3.day, priority: "高", created_at: Time.current - 3.day, user: user)}
    let!(:second_task) {FactoryBot.create(:task, name: "t_s_n", time_limit: Time.current + 7.day, priority: "低", created_at: Time.current - 2.day, user: user)}
    let!(:third_task) {FactoryBot.create(:task, name: "sample_2", time_limit: Time.current + 5.day, priority: "中", created_at: Time.current - 1.day, user: user)}
    before do
      visit new_session_path
      fill_in "session_email", with: '1ban@mail.com'
      fill_in "session[password]", with: 'aaaaaa'
      click_button "Log in"
    end
    context '作成日時でソートをした場合' do
      it "新しいタスクが一番上に表示される" do
        visit tasks_path
        click_link "作成日新しい順"
        task_list_f = first('.spec_test_name')
        expect(task_list_f).to have_content "sample_2"
      end
    end
    context '終了期限でソートをした場合' do
      it "終了期限の最も遠いタスクが一番上に表示される" do
        visit tasks_path
        click_on '終了期限遠い順'
        task_list = all(".spec_test_name")
        # binding.pry
        expect(task_list[0]).to have_content "t_s_n"
      end
    end
    context '終了期限でソートをした場合' do
      it "終了期限の最も近いタスクが一番上に表示される" do
        visit tasks_path
        click_link "優先度高い順"
        task_list_f = first('.spec_test_name')
        expect(task_list_f).to have_content "task_name1"
      end
    end
  end
  describe '詳細表示機能' do
    let!(:user) {FactoryBot.create(:user)}
    let!(:label) {FactoryBot.create(:label)}
    before do
      visit new_session_path
      fill_in "session_email", with: '1ban@mail.com'
      fill_in "session[password]", with: 'aaaaaa'
      click_button "Log in"
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        FactoryBot.create(:task, name: 'name', content: 'content', user: user, labels: [label])
        visit tasks_path
        click_link "詳細"
        expect(page).to have_content 'name'
      end
    end
  end
  describe '検索機能' do
    let!(:user) {FactoryBot.create(:user)}
    let!(:task) {FactoryBot.create(:task, name: "task_name1", status: "未着手", user: user)}
    let!(:second_task) {FactoryBot.create(:task, name: "sample_1", status: "着手中", user: user)}
    let!(:third_task) {FactoryBot.create(:task, name: "sample_2", status: "完了", user: user, labels: [label])}
    let!(:label) {FactoryBot.create(:label)}
    before do
      visit new_session_path
      fill_in "session_email", with: '1ban@mail.com'
      fill_in "session[password]", with: 'aaaaaa'
      click_button "Log in"
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in "task[name]", with: 'as'
        # 検索ボタンを押す
        click_button "絞り込み"
        expect(page).to have_content '未着手'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        visit tasks_path
        # プルダウンを選択する「select」について調べてみること
        select "着手中", from: 'task[status]'
        # binding.pry
        click_button "絞り込み"
        expect(page).to have_content 'e_1'
      end
    end
    context 'ラベル検索をした場合' do
      it "ラベルに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "label", from: 'task[label_id]'
        click_button "絞り込み"
        expect(page).to have_content 'sample_2'
      end
    end
    context 'タイトルのあいまい検索とステータス検索とラベル検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致し、かつラベルに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "task[name]", with: 'ple'
        select "完了", from: 'task[status]'
        select "label", from: 'task[label_id]'
        click_button "絞り込み"
        expect(page).to have_content 'sample_2'
      end
    end
  end
  describe '詳細表示機能' do
    let!(:user) {FactoryBot.create(:user)}
    before do
      visit new_session_path
      fill_in "session_email", with: '1ban@mail.com'
      fill_in "session[password]", with: 'aaaaaa'
      click_button "Log in"
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        FactoryBot.create(:task, name: 'name', content: 'content', user: user)
        visit tasks_path
        click_link "詳細"
        expect(page).to have_content 'name'
      end
    end
  end
end
