class ApoIdToCrawlItems < ActiveRecord::Migration[5.0]
  def change
    add_column :crawl_items, :apo_id, :string 
    add_column :seed_items, :apo_id, :string 
  end
end
