class ChangeSeedItemsXmlCol < ActiveRecord::Migration[5.0]
  def change
    change_column :seed_items, :source_xml, :text
  end
end
