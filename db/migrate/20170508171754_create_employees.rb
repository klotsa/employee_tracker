class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table(:employees) do |d|
      d.column(:name, :string)
      d.column(:department_id, :integer)

      d.timestamps()
    end
  end
end
