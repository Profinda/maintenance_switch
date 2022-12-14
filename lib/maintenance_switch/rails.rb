require_relative "base"

class MaintenanceSwitch::Railtie < Rails::Railtie
  railtie_name :maintenance_switch

  rake_tasks do
    path = File.expand_path(__dir__)
    Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
  end

  initializer("maintenance-switch.prepend") do |app|
    next if Rails.env.test?

    app.config.middleware.insert_before(Rack::Timeout, MaintenanceSwitch::Base)
  end
end