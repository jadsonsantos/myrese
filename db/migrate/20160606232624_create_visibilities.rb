class CreateVisibilities < ActiveRecord::Migration
  def change
    create_table :visibilities do |t|
      t.string :type

      t.timestamps null: false
    end
  end
end
