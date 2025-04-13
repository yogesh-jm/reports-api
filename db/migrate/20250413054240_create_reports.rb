class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.string :title, null: false
      t.text :description
      t.string :reporter, null: false

      t.timestamps
    end
  end
end
