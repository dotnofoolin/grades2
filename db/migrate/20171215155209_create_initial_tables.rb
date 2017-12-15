class CreateInitialTables < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :student_id
      t.string :name
      t.timestamps null: false
    end

    create_table :courses do |t|
      t.references :student, index: true
      t.string :name
      t.float :average
      t.datetime :last_update
      t.timestamps null: false
    end

    create_table :assignments do |t|
      t.references :student, index: true
      t.references :course, index: true
      t.datetime :due_date
      t.datetime :date_assigned
      t.string :name
      t.string :category
      t.float :score
      t.float :total_points
      t.timestamps null: false
    end

    add_foreign_key :courses, :students
    add_foreign_key :assignments, :students
    add_foreign_key :assignments, :courses
  end
end
