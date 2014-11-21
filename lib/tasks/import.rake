namespace :db do
  desc "Import concepts from db/import_files"
  task :import_concepts => :environment do
    path = "db/import_files/"

    Concept.destroy_all
    importer = GraphImporter.new()
    importer.import_new_nodes(File.open(path + "concepts.txt", "rb").read)
    importer.import_new_relationships(File.open(path + "subsequents.txt", "rb").read)
    GraphCache.get_cache.cache_everything
  end
end
