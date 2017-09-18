class UpdateSeedItemTable < ActiveRecord::Migration[5.0]
  def change
    add_column :seed_items, :verified, :boolean
  end
end
