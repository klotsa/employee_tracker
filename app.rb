require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/employee')
require('./lib/division')
require('./lib/project')
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

#view individual division
get('/divisions/:id') do
  @division = Division.find(params.fetch('id').to_i())
  erb(:division)
end

#add employee to individual division
post('/division_employees') do
  name = params.fetch('name')
  division_id = params.fetch('division_id').to_i
  new_employee = Employee.create({:name => name, :division_id => division_id})
  @division = Division.find(division_id)
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

#view all projects
get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

#create a new project
get('/projects/new') do
  erb(:project_form)
end

#add a new project
post('/projects') do
  input_description = params.fetch('description')
  new_project = Project.create({:description => input_description})
  @projects = Project.all()
  erb(:projects)
end

#view individual project
get('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  @employees = Employee.all()
  erb(:project)
end


patch('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  project_id = params.fetch('id').to_i()
  employee_id = params.fetch('employee_id')
  Employee.find(employee_id).update({:project_id => project_id})
  @employees = Employee.all()
  erb(:project)
end

patch('/projects/remove/:id') do
  @project = Project.find(params.fetch('id').to_i())
  project_id = params.fetch('id').to_i()
  employee_id = params.fetch('employee_id')
  Employee.find(employee_id).update({:project_id => nil})
  @employees = Employee.all()
  erb(:project)
end
