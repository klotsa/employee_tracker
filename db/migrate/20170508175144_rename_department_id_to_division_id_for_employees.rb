class RenameDepartmentIdToDivisionIdForEmployees < ActiveRecord::Migration[5.1]
  def change
    remove_column(:employees, :department_id, :integer)
    add_column(:employees, :division_id, :integer)
  end
end
