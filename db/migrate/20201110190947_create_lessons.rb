class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.string :location
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
