require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/employee')
require('./lib/division')
also_reload('lib/**/*.rb')
require("pg")

get('/') do
  erb(:index)
end

#add a division
get('/divisions/new') do
  erb(:division_form)
end

#post divisions
post('/divisions') do
  department = params.fetch('department')
  new_division = Division.create({:department => department})
  @divisions = Division.all
  erb(:divisions)
end

#view all divisions
get('/divisions') do
  @divisions = Division.all
  erb(:divisions)
end

#view individual divisions
get('/divisions/:id') do
  @division = Division.find(params.fetch('id').to_i())
  erb(:division)
end


#edit divisions
get('/divisions/:id/edit') do
  @division = Division.find(params.fetch('id').to_i())
  erb(:division_edit_form)
end

#update individual division
patch('/divisions/:id') do
  @division = Division.find(params.fetch('id').to_i())
  update_department = params.fetch('department')
  @division.update({:department => update_department})
  erb(:division)
end

#delete individual division
delete('/divisions/:id') do
  @division = Division.find(params.fetch('id').to_i())
  @division.delete()
  @divisions = Division.all()
  erb(:divisions)
end

#view all employees
get('/employees') do
  @employees = Employee.all()
  erb(:employees)
end

#add a new employee
get('/employees/new') do
  erb(:employee_form)
end

#post a new employee
post('/employees') do
  new_name = params.fetch('name')
  new_employee = Employee.create({:name => new_name})
  @employees = Employee.all()
  erb(:employees)
end

#view individual employee
get('/employees/:id') do
  @employee = Employee.find(params.fetch('id').to_i)
  erb(:employee)
end

#find and edit an individual employee info
get('/employees/:id/edit') do
  @employee = Employee.find(params.fetch('id').to_i)
  erb(:employee_edit_form)
end

#update an individual employee info
patch('/employees/:id') do
  @employee = Employee.find(params.fetch('id').to_i)
  new_name = params.fetch('name')
  @employee.update({:name => new_name})
  erb(:employee)
end

#delete an employee
delete('/employees/:id') do
  @employee = Employee.find(params.fetch('id').to_i)
  @employee.delete()
  #a full list of employees to be shown on the employee page is required
  @employees = Employee.all()
  erb(:employees)
end
