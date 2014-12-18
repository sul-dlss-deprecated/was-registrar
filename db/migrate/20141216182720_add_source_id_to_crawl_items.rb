class AddSourceIdToCrawlItems < ActiveRecord::Migration
  def change
    add_column :crawl_items, :source_id, :string
  end
end
