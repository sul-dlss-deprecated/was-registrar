class AddSourceIdToSeedItems < ActiveRecord::Migration[5.0]
  def change
    add_column :seed_items, :source_id, :string

  end
end
