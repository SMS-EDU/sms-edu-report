Dir.glob('./{models,controllers,services,config}/*.rb')
  .each do |file|
  require file
end

require 'sinatra/activerecord/rake'
require 'config_env/rake_tasks'
require 'rake/testtask'

task default: [:local_and_running]

desc 'Local and running'
task :local_and_running do
  Rake::Task['local:local_and_running'].invoke
end

desc 'Heroku and running'
task :heroku_and_running do
  Rake::Task['heroku:up_and_running'].invoke
end

desc 'Run all tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
end

namespace :local do
  desc 'Bundle Install'
  task :bundle_install do
    system 'bundle install --without production'
  end

  desc 'Set up local database'
  task :local_db do
    system 'rake db:migrate'
  end

  desc 'Set up local database'
  task :my_local_db do
    system 'rm db/dev.db db/schema.rb'
    system 'rake db:migrate'
  end

  desc 'Dump DB'
  task :dump_db do
    system 'rm db/dev.db db/schema.rb'
  end

  desc 'Dump Migrations'
  task :dump_migration do
    system 'rm -rf db/migrate/'
  end

  desc 'Run post requests'
  task :default_post_requests do
    go_to_route = 'http -f -v POST localhost:9292/api/v1/'
    params = 'record_type==grades session==2011/2012 term==1st '\
             'student_class==JSS3 uploader_email==taka@gmail.com'
    system "#{go_to_route}students file@test_files/test_st.csv"
    system "#{go_to_route}schools file@test_files/test_sch.csv"
    system "#{go_to_route}guardians file@test_files/test_g.csv"
    system "#{go_to_route}uploaders file@test_files/test_u.csv"
    system "#{go_to_route}/records file@test_files/test_r.csv #{params}"
  end

  desc 'Set up local'
  task local_and_running: [:bundle_install, :local_db] do
  end
end

namespace :heroku do
  desc 'Start a heroku'
  task :create_heroku do
    system "heroku create #{ENV['APP_NAME']}"
  end

  desc 'Push master to heroku'
  task :push_to_heroku do
    system 'git push -f heroku master'
  end

  desc 'Create heroku database'
  task :make_heroku_db do
    system 'heroku addons:create heroku-postgresql:hobby-dev'
  end

  desc 'Set up heroku database'
  task migrate_heroku_db: [:make_heroku_db] do
    system 'heroku run rake db:migrate'
  end

  desc 'Transfer heroku environment variables'
  task :transfer_config_env do
    system 'rake config_env:heroku'
  end

  desc 'And it\'s a wrap'
  task up_and_running: [:create_heroku, :push_to_heroku, :migrate_heroku_db,
                        :transfer_config_env] do
  end
end

desc 'Generate DB & MSG keys'
task :keys_for_config_env do
  2.times do
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    print 'either key: '
    puts Base64.urlsafe_encode64(key)
  end
end
