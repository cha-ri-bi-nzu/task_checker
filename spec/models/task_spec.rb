require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(content: '')
        expect(task).to_not be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = User.new(name: 'テストさん')
        task = Task.new(name: 'テスト', content: '成功', user: user)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:user) { FactoryBot.create(:user, name: 'user_name1') }
    let!(:task) { FactoryBot.create(:task, name: 'task', status: "未着手", user: user) }
    let!(:second_task) { FactoryBot.create(:task, name: "sample", status: "未着手", user: user) }
    let!(:third_task) { FactoryBot.create(:task, name: "task01", status: "着手中", user: user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.name_select('ta')).to include(task)
        expect(Task.name_select('ta')).not_to include(second_task)
        expect(Task.name_select('ta')).to include(third_task)
        expect(Task.name_select('ta').count).to eq 2
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_select('着手中')).to_not include(task)
        expect(Task.status_select('着手中')).not_to include(second_task)
        expect(Task.status_select('着手中')).to include(third_task)
        expect(Task.status_select('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.name_select('sk') && Task.status_select('未着手')).to include(task)
      end
    end
  end
end
