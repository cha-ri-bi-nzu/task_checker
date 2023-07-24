require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  describe '新規作成機能' do
    context 'ユーザーを新規作成した場合' do
      it 'ユーザーのマイページに遷移される' do
        visit new_user_path
        # sleep(1)
        fill_in "user_name", with: 'user1_name'
        fill_in "user_email", with: 'aiueo@email.com'
        fill_in "user_password", with: 'aiueoka'
        fill_in "user_password_confirmation", with: 'aiueoka'
        click_button "登録"
        # binding.pry
        expect(current_path).to eq user_path(1)
        expect(page).to have_content 'user1_name'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'アカウント作成完了'
      end
    end
  end
  describe 'ログイン要請機能' do
    context 'ログインせずにタスク一覧画面にアクセスした場合' do
      it 'ログイン画面に遷移される' do
        visit user_path(1)
        expect(current_path).to eq new_session_path
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'ログインをして下さい'
      end
    end
  end
end

RSpec.describe 'セッション機能', type: :system do
  describe 'ログイン機能' do
    let!(:user) {FactoryBot.create(:user, id: 3, name: "user_name1", email: "1ban@mail.com", password: "aaaaaa")}
    context 'ログインをした場合' do
      it "ログイン状態で自分のマイページに遷移される" do
        visit new_session_path
        fill_in "session_email", with: '1ban@mail.com'
        fill_in "session[password]", with: 'aaaaaa'
        click_button "Log in"
        expect(current_path).to eq user_path(3)
        expect(page).to have_content 'user_name1さんのマイページ'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content 'プロフィール編集'
      end
    end
    before do
      visit new_session_path
      fill_in "session_email", with: '1ban@mail.com'
      fill_in "session[password]", with: 'aaaaaa'
      click_button "Log in"
    end
    context 'ログアウトをした場合' do
      it "ログアウト状態でログイン画面に遷移される" do
        visit user_path(3)
        click_link "ログアウト"
        expect(current_path).to eq new_session_path
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe 'ユーザー確認機能' do
    let!(:user) {FactoryBot.create(:user, id: 1, name: "user1_name", email: "aiueo@email.com", password: "aiueoka", admin: "一般")}
    let!(:second_user) {FactoryBot.create(:user, id: 3, name: "user_name1", email: "1ban@mail.com", password: "aaaaaa", admin: "一般")}
    before do
      visit new_session_path
      fill_in "session_email", with: '1ban@mail.com'
      fill_in "session[password]", with: 'aaaaaa'
      click_button "Log in"
    end
    context '一般ユーザーが他のユーザーのマイページにアクセスした場合' do
      it "自分のタスク一覧画面に遷移される" do
        visit user_path(1)
        expect(current_path).to eq tasks_path(3)
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content '新タスク登録'
        expect(page).to have_content '他のユーザーのページは閲覧できません'
      end
    end
  end
end

RSpec.describe '管理画面機能', type: :system do
  describe '管理権限確認機能' do
    let!(:user) {FactoryBot.create(:user, id: 1, name: "user1_name", email: "aiueo@email.com", password: "aiueoka", admin: "管理者")}
    let!(:second_user) {FactoryBot.create(:user, id: 3, name: "user_name1", email: "1ban@mail.com", password: "aaaaaa", admin: "一般")}
    context '管理ユーザーが管理画面にアクセスした場合' do
      before do
        visit new_session_path
        fill_in "session_email", with: 'aiueo@email.com'
        fill_in "session_password", with: 'aiueoka'
        click_button "Log in"
      end
      it '管理画面に遷移される' do
        click_link "管理者画面"
        expect(current_path).to eq admin_users_path
        expect(page).to have_content '管理者画面'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'ユーザー一覧'
        expect(page).to have_content '新規ユーザー登録'
      end
    end
    context '一般ユーザーが管理画面にアクセスした場合' do
      before do
        visit new_session_path
        fill_in "session_email", with: '1ban@mail.com'
        fill_in "session[password]", with: 'aaaaaa'
        click_button "Log in"
      end
      it "自分のタスク一覧画面に遷移される" do
        visit admin_users_path
        expect(current_path).to eq tasks_path(3)
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content '新タスク登録'
        expect(page).to have_content '管理者権限がない為、アクセス出来ません！'
      end
    end
  end
  describe 'ユーザー管理機能' do
    let!(:user) {FactoryBot.create(:user, name: "user1_name", email: "aiueo@email.com", password: "aiueoka", admin: "管理者")}
    let!(:second_user) {FactoryBot.create(:user, name: "user_name1", email: "1ban@mail.com", password: "aaaaaa", admin: "一般")}
    let!(:third_user) {FactoryBot.create(:user, name: "user_name10", email: "10@mail.com", password: "aaaaaa", admin: "管理者")}
    let!(:task) {FactoryBot.create(:task, user: second_user)}
    let!(:second_task) {FactoryBot.create(:task, user: second_user)}
    before do
      visit new_session_path
      fill_in "session_email", with: 'aiueo@email.com'
      fill_in "session_password", with: 'aiueoka'
      click_button "Log in"
      click_link "管理者画面"
    end
    context '管理ユーザーがユーザーの新規登録をした場合' do
      it "ユーザーが新規登録される" do
        click_link "新規ユーザー登録"
        fill_in "user_name", with: 'user_name2'
        fill_in "user_email", with: '2ban@mail.com'
        fill_in "user_password", with: 'bbbbbb'
        fill_in "user_password_confirmation", with: 'bbbbbb'
        click_button "登録"
        expect(current_path).to eq admin_users_path
        expect(page).to have_content '管理者画面'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'user_name2'
        expect(page).to have_content '一般'
        expect(page).to have_content '0'
        expect(page).to have_content 'user_name2さんのアカウントを作成しました'
      end
    end
    context '管理ユーザーがユーザーの詳細画面にアクセスした場合' do
      it "該当のユーザー詳細画面に遷移される" do
        visit user_path(2)
        expect(current_path).to eq user_path(2)
        expect(page).to have_content 'user_name1さんのマイページ'
        expect(page).to have_content '管理者画面'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content 'プロフィール編集'
      end
    end
    context '管理ユーザーが編集画面でユーザー情報の編集をした場合' do
      it '該当ユーザーの情報が編集される' do
        visit user_path(2)
        click_link "プロフィール編集"
        fill_in "user_name", with: 'user_name3'
        fill_in "user_email", with: '2ban@mail.com'
        fill_in "user_password", with: 'bbbbbb'
        fill_in "user_password_confirmation", with: 'bbbbbb'
        click_button "更新"
        expect(current_path).to eq admin_users_path
        expect(page).to have_content '管理者画面'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'ユーザー一覧'
        expect(page).to have_content 'user_name3'
        expect(page).to have_content '一般'
        expect(page).to have_content '2'
        expect(page).to have_content '新規ユーザー登録'
        expect(page).to have_content 'user_name3さんのプロフィールを編集しました'
      end
    end
    context '管理ユーザーがユーザーを削除した場合' do
      it "該当ユーザーの情報が削除される" do
        find('#delete_2').click
        # find("a[data-confirm='本当に削除しますか？'][data-method='delete'][href='#{admin_user_path(2)}']").click
        # accept_alert do
        #   find('//*[@id="delete_2"]').click
        # end
        # accept_confirm("本当に削除しますか？")
        expect(current_path).to eq admin_users_path
        expect(page).to have_content '管理者画面'
        expect(page).to have_content 'マイページ'
        expect(page).to have_content 'ログアウト'
        expect(page).to have_content 'ユーザー一覧'
        expect(page).not_to have_content 'user_name3'
        expect(page.all("一般").count).to eq 0
        expect(page).not_to have_content '2'
        expect(page).to have_content '新規ユーザー登録'
        expect(page).to have_content 'user_name1さんのアカウントを削除しました'
      end
    end
  end
end