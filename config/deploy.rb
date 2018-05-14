# config valid for current version and patch releases of Capistrano
lock "3.10.2"
server '149.28.18.198', port: 22, roles: [:app, :web, :db], primary:true
set :repo_url, "git@github.com:IchikiRyo/CafeShaker.git"
set :application, "cafeshares"
set :user, 'deploy'
set :ssh_options, {
  forward_agent: true,
  user: fetch(:user),
  keys: %w(~/.ssh/id_rsa_cafeshares)
}
set :puma_threads, [4, 16]
set :puma_workers, 0
set :pty,          true
set :use_sudo,     false
set :stage,        :production
set :deploy_via,   :remote_cache
set :deploy_to,    "/var/www/#{fetch(:application)}"
set :puma_bind,    "unix:/var/www/cafeshares/shared/tmp/sockets/cafeshares-puma.sock"
set :puma_state,   "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,     "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :rbenv_type, :system
set :rbenv_ruby, '2.3.1'

# It's skip migration if files in db/migrate not modified
set :conditonally_migrate, true

# デプロイ対象としたくないディレクトリを記載
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')


# set :linked_dirs, fetch(:linked_dirs, []).push('tmp/pids')
# set :linked_dirs, fetch(:linked_dirs, []).push('tmp/cache')
# set :linked_dirs, fetch(:linke_dirs, []).push('tmp/sockets')
# set :linked_dirs, fetch(:linked_dirs, []).push('vendor/bundle')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/system')
# set :linked_dirs, fetch(:linked_dirs, []).push('public/uploads')
# デプロイ対象としたくないファイルを記載
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/secrets.yml'
)

set :keep_releases, 3

  namespace :puma do
    desc 'Create Directories for Puma pids and Socket'
    task :make_dirs do
      on roles(:app) do
        execute "mkdir #{shared_path}/tmp/sockets -p"
        execute "mkdir #{shared_path}/tmp/pids -p"
      end
    end
    before :start, :make_dirs
  end

  namespace :deploy do
    # task :cleanup, :except => {:no_release => true} do
    #   count = fetch(:keep_releases, 5).to_i
    #   run "ls -1dt #{release_path}/* | tail -n +#{count + 1} | #{sudo :as => 'root'} xargs rm -rf"
    # end
    desc "Make sure local git is sync with remote."
    task :check_revision do
      on roles(:app) do
        unless `git rev-parse HEAD` == `git rev-parse origin/master`
          puts "WARNING: HEAD is not the same as origin/master"
          puts "Run `git push` to sync changes."
          exit
        end
      end
    end
    desc 'Upload database.yml'
    task :upload do
      on roles(:app) do |host|
        if test "[ ! -d #{shared_path}/config ]"
          execute "mkdir -p #{shared_path}/config"
        end
        upload!('config/database.yml', "#{shared_path}/config/database.yml")
        # upload!('config/secrets.yml', "#{shared_path}/config/secrets.yml")
      end
    end
    # desc 'Symlink linked files'
    # task :linked_files do
    #   naxt unless any? :linked_files
    #   on roles :app do
    #     execute :mkdir, '-pv', linked_files_dirs(release_path)

    #     fetch(:linked_files).each do |file|
    #       target = release_path.join(file)
    #       source = shared_path.join(file)
    #       unless test "[ -L #{target} ]"
    #         if test "[ -f #{target} ]"
    #           execute :rm, target
    #         end
    #         execute :ln, '-s', source, target
    #       end
    #     end
    #   end
    # end
    # desc 'Check files to be linked exist in shared'
    # task :linked_files do
    #   next unless any? :linked_files
    #   on roles :app do |host|
    #     linked_files(shared_path).each do |file|
    #       unless test "[ -f #{file} ]"
    #         error t(:linked_files_does_not_exist, file: file, host: host)
    #         exit 1
    #       end
    #     end
    #   end
    # end


    desc 'Initial Deploy'
    task :initial do
      on roles(:app) do
        before 'deploy:restart', 'puma:start'
        invoke 'deploy'
      end
    end
    # Rake::Task["deploy:symlink:release"].clear
    # namespace :symlink do
    #   desc 'Symlink release to current'
    #   task :release do
    #     on release_roles :all do
    #       execute :ln, '-s', release_path, current_path
    #     end
    #   end
    # end
    desc 'Restart application'
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        Rake::Task["puma:restart"].reenable
        invoke 'puma:restart'
      end
    end

    before :starting, :check_revision
    before :starting, 'deploy:upload'
    after :finishing, :compile_assets
    # before 'deploy', 'deploy:cleanup'
    after :finishing, :cleanup
    # after :finishing, :restart
  end




# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
