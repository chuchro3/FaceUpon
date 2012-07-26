desc "This task is called by the Heroku scheduler add-on"
namespace :db do

  task :update_database => :environment do
    Rake::Task['db:groupon[false,false,false,true]'].invoke    
  end

end
