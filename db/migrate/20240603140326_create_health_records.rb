class CreateHealthRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :health_records do |t|
      t.references :animal, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true
      t.string :history

      t.timestamps
    end
  end
end
