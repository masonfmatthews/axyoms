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

# On Heroku, this cannot run.  Instead, run:
# 1. heroku pg:reset DATABASE
# 2. heroku run rake db:migrate
# 3. heroku run rake db:import_concepts
# 4. heroku run rake db:seed
