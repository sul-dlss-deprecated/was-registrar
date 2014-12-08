class AddSourceIdToSeedItems < ActiveRecord::Migration
  def change
    add_column :seed_items, :source_id, :string

  end
end
