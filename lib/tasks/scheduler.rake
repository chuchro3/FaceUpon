desc "This task is called by the Heroku scheduler add-on"
task :update_database => :environment do
  Rake::Task['db:groupon[false,false,false,true]'].invoke    
end
