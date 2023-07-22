require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_user_path
        # sleep(1)
        fill_in "user_name", with: 'user1_name'
        fill_in "user_email", with: 'aiueo@email.com'
        fill_in "user_password", with: 'aiueoka'
        fill_in "user_password_confirmation", with: 'aiueoka'
        click_button "登録"
        # binding.pry
        expect(page).to have_content 'user1_name'
      end
    end
  end
  describe 'ログイン要請機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:user, name: "user")
      FactoryBot.create(:second_user, name: "sample")
    end
    context 'ログインせずにタスク一覧画面にアクセスした場合' do
      it 'ログイン画面に遷移される' do
        FactoryBot.create(:user, name: 'name', content: 'content')
        visit users_path
        expect(page).to have_content 'name'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:user, id: 1, name: 'name1', content: 'content4', created_at: Time.current + 1.day)
        FactoryBot.create(:user, id: 2, name: 'name2', content: 'content8', created_at: Time.current + 2.day)
        FactoryBot.create(:user, id: 3, name: 'name5', content: 'content4', created_at: Time.current + 3.day)
        visit users_path
        user_list_f = first('.spec_testname')
        expect(user_list_f).to have_content "name5"
      end
    end
  end
end

RSpec.describe 'セッション機能', type: :system do
  describe 'ログイン機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:user, name: "user_name1", time_limit: Time.current - 7.day, priority: "中", created_at: Time.current + 1.day)
      FactoryBot.create(:second_user, name: "t_s_n", time_limit: Time.current - 3.day, priority: "低", created_at: Time.current + 2.day)
      FactoryBot.create(:third_user, name: "sample_2", time_limit: Time.current - 5.day, priority: "高", created_at: Time.current + 3.day)
    end
    context 'ログインをした場合' do
      it "ログイン状態で自分のマイページに遷移される" do
        visit users_path
        click_link "作成日新しい順"
        user_list_f = first('.spec_testname')
        expect(user_list_f).to have_content "sample_2"
      end
    end
    context 'ログアウトをした場合' do
      it "ログアウト状態でログイン画面に遷移される" do
        visit users_path
        click_link "終了期限遠い順"
        user_list_f = first('.spec_testname')
        expect(user_list_f).to have_content "t_s_n"
      end
    end
  end
  describe 'ユーザー確認機能' do
    context '一般ユーザーが他のユーザーのマイページにアクセスした場合' do
      it "自分のタスク一覧画面に遷移される" do
        visit users_path
        click_link "優先度高い順"
        user_list_f = first('.spec_testname')
        expect(user_list_f).to have_content "sample_2"
      end
    end
  end
end

RSpec.describe '管理画面機能', type: :system do
  describe '管理権限確認機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:user, name: "user_name1", status: "未着手")
      FactoryBot.create(:second_user, name: "sample_1", status: "着手中")
      FactoryBot.create(:third_user, name: "sample_2", status: "完了")
    end
    context '管理ユーザーが管理画面にアクセスした場合' do
      it '管理画面に遷移される' do
        FactoryBot.create(:user, name: 'name', content: 'content')
        visit users_path
        click_link "詳細"
        expect(page).to have_content 'name'
      end
    end
    context '一般ユーザーが管理画面にアクセスした場合' do
      it "自分のタスク一覧画面に遷移される" do
        visit users_path
        # タスクの検索欄に検索ワードを入力する (例: user)
        fill_in "user[name]", with: 'as'
        # 検索ボタンを押す
        click_button "絞り込み"
        expect(page).to have_content '未着手'
      end
    end
  end
  describe 'ユーザー管理機能' do
    context '管理ユーザーがユーザーの新規登録をした場合' do
      it "ユーザーが新規登録される" do
        # ここに実装する
        visit users_path
        # プルダウンを選択する「select」について調べてみること
        select "着手中", from: 'user[status]'
        # binding.pry
        click_button "絞り込み"
        expect(page).to have_content 'e_1'
      end
    end
    context '管理ユーザーがユーザーの詳細画面にアクセスした場合' do
      it "該当のユーザー詳細画面に遷移される" do
        visit users_path
        fill_in "user[name]", with: 'ple'
        select "完了", from: 'user[status]'
        click_button "絞り込み"
        expect(page).to have_content 'sample_2'
      end
    end
    context '管理ユーザーが編集画面でユーザー情報の編集をした場合' do
      it '該当ユーザーの情報が編集される' do
        FactoryBot.create(:user, name: 'name', content: 'content')
        visit users_path
        click_link "詳細"
        expect(page).to have_content 'name'
      end
    end
    context '管理ユーザーがユーザーを削除した場合' do
      it "該当ユーザーの情報が削除される" do
        # ここに実装する
        visit users_path
        # プルダウンを選択する「select」について調べてみること
        select "着手中", from: 'user[status]'
        # binding.pry
        click_button "絞り込み"
        expect(page).to have_content 'e_1'
      end
    end
  end
end
