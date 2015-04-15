namespace :db do
  desc "Clear and set up both Neo4j and PostgreSQL, including seeds."
  task :setup_all => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:import_concepts"].invoke
    Rake::Task["db:seed"].invoke
  end
end
