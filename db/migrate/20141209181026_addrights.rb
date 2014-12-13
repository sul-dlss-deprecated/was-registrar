class Addrights < ActiveRecord::Migration
  def change
        add_column :seed_items, :rights, :string

  end
end
