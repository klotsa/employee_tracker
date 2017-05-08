class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table(:projects) do |d|
      d.column(:description, :string)
    end

    add_column(:employees, :project_id, :integer)  
  end
end
