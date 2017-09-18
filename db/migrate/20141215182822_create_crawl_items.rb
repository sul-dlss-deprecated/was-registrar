class CreateCrawlItems < ActiveRecord::Migration[5.0]
  def change
    create_table :crawl_items do |t|
        t.column "druid_id",      :string
        t.column "job_directory",        :string
        t.column "collection_id", :string
        t.column "on_disk", :boolean
        t.column "registered_datetime", :date
        t.timestamps
 
    end
  end
end
