class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :line_number, null: false
      t.string  :line_text

      t.timestamps null: false
    end
  end
end
