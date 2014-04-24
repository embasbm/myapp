class AddSuccessorToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :successor_id, :integer
  end
end
