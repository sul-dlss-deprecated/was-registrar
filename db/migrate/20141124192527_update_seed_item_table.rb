class UpdateSeedItemTable < ActiveRecord::Migration
  def change
    add_column :seed_items, :verified, :boolean
  end
end
