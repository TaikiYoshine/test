# frozen_string_literal: true

namespace :task_user do
  desc '任意のUserモデルのレコードを作成'
  task create: :environment do
    User.create(name: 'たすく！', email: 'task@gmail.com', sex: '男性', birth: '2000-5-5', hobby: 'タスク実行', job: 'ノージョブ')
  end
end
