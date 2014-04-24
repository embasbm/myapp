class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :predecessor_id

      t.timestamps
    end
  end
end
