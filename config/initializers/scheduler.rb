require 'rufus-scheduler'
require 'importer/hac'

unless defined?(Rails::Console) || Rails.env.test?
  scheduler = Rufus::Scheduler.new

  first_at = Time.parse('07:00:00')
  first_at = Time.parse('07:00:00') + 1.day if Time.now > Time.parse('07:00:00')
  scheduler.every '12h', first_at: first_at do
    Importer::Hac.new.import
  end
end
