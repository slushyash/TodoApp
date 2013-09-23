require 'data_mapper'
require 'dm-is-tree'
#DataMapper::Logger.new(STDOUT, :debug) # DEBUG, logs SQL queries
#DataMapper.setup :default, "sqlite://#{Dir.pwd}/database.db"
DataMapper.setup :default, "sqlite::memory:"
DataMapper::Model.raise_on_save_failure = true

require_relative 'task'
require_relative 'category'
require_relative 'location'
require_relative 'step'

DataMapper.finalize.auto_upgrade!

require 'dm-sweatshop'
require_relative 'fixtures'
require_relative 'schedule_planner'