class Addrights < ActiveRecord::Migration[5.0]
  def change
        add_column :seed_items, :rights, :string

  end
end
