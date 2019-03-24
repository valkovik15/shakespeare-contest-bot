class CreateInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :inputs do |t|
      t.integer :task_id
      t.string :question
      t.integer :level

      t.timestamps
    end
  end
end
