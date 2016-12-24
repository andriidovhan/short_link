class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.text :origin
      t.string :shorten
    end
  end
end
