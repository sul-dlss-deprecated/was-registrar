class AddSourceIdToCrawlItems < ActiveRecord::Migration[5.0]
  def change
    add_column :crawl_items, :source_id, :string
  end
end
