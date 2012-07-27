class AddQuotes < ActiveRecord::Migration
  def up
    create_table :quotes do |q|
      q.string :quote
      q.string :author

      q.timestamps
    end
  end

  def down
    drop_table :quotes
  end
end
