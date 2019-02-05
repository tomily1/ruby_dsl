ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), '..', 'app', 'routes.yml')))

db_config_file = File.join(File.dirname(__FILE__ ), 'database.yml')

if File.exists? db_config_file
  config = YAML.load(File.read(db_config_file))
  DB = Sequel.postgres(config[ENV['RACK_ENV']])
  Sequel.extension :migration
end

Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), '..', 'app', '**', '*.rb')].each {|file| require file }

# TODO: If there is a database connection, running all the migrations
if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'db', 'migrations'))
end
