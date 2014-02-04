Mongoid.configure do |config|
  uri = ENV['BOXEN_MONGODB_URL']
  uri ||= "mongodb://guest:guest@localhost:27017/"
  uri += "#{DATABASE}"

  config.sessions = { :default => { :uri => uri, :options => { :safe => true } } }

  ::BSON = ::Moped::BSON
  if ENV['LOGGER_LEVEL']
    Moped.logger = Logger.new(STDOUT).tap { |l| l.level = ENV['LOGGER_LEVEL'].to_i }
  end
end

RSpec.configure do |config|
  config.before(:each) do
    Mongoid.purge!
    Mongoid::IdentityMap.clear
  end
end
