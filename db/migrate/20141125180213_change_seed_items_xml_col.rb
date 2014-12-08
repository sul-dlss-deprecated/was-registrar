class ChangeSeedItemsXmlCol < ActiveRecord::Migration
  def change
    change_column :seed_items, :source_xml, :text
  end
end
