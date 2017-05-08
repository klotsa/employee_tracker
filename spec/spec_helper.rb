
ENV['RACK_ENV'] = 'test'
require("rspec")
require("pg")
require("sinatra/activerecord")
require("./lib/division")
require("./lib/employee")
require(".lib/project")


RSpec.configure do |config|
  config.after(:each) do
    Employee.all().each do |employee|
      employee.destroy()
    end
    Division.all().each do |division|
      division.destroy()
    end
    Project.all().each do |project|
      project.destroy()
    end
  end
end
