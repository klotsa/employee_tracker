class AddNotAssigned < ActiveRecord::Migration[5.1]
  def change
    add_column(:employees, :not_assigned, :boolean)
  end
end
