class ApoIdToCrawlItems < ActiveRecord::Migration
  def change
    add_column :crawl_items, :apo_id, :string 
    add_column :seed_items, :apo_id, :string 
  end
end
