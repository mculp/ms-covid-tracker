require 'rake'
require 'hanami/rake_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

# Rakefile
desc "Scrape latest data"
task scrape: :environment do
  raw_html = if ENV['FILENAME']
               File.read(ENV['FILENAME'])
             else
               HTTParty.get(Scrape::WEBSITE_URL)
             end

  Scrape.new(raw_html).call
end

desc "Set previous update ids"
task add_previous_updates: :environment do
  AddPreviousUpdates.new.call
end
