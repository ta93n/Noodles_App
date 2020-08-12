# capistranoのバージョン固定
lock '3.4.0'

# デプロイするアプリケーション名
set :application, 'noodles-app'

# cloneするgitのレポジトリ
set :repo_url, 'git@github.com:ta93n/Noodles_App.git'

# deployするブランチ デフォルトはmaster
set :branch, 'master'

# deploy先のディレクトリ
set :deploy_to, '/var/www/rails/sample'

# シンボリックリンク(ショートカットみたいなもの)を貼るファイル
set :linked_files, fetch(:linked_files, []).push('config/settings.yml')

# シンボリックリンクをはるフォルダ
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# 保持するバージョンの個数 (capistranoを通じてデプロイされたアプリは、releasesというフォルダにひとまとめにされる)
set :keep_releases, 5

# rubyのバージョン
set :rbenv_ruby, '2.6.5'

# 出力するログのレベル
set :log_level, :debug

# cap deploy時に実行される
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
