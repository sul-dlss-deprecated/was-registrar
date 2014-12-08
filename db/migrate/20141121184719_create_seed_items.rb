class CreateSeedItems < ActiveRecord::Migration

  def up
  	  create_table :seed_items do |t|
  	  	t.column "druid_id",      :string
        t.column "uri",           :string
        t.column "embargo",       :boolean
        t.column "source",        :string
        t.column "collection_id", :string
        t.column "source_xml",    :string
        t.column "source_file",   :string
        t.column "import_date",   :date
        t.timestamps
    end
  end

  def down
  	drop_table :seed_items
  end
end
