# frozen_string_literal: true

# migration
class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :number

      t.timestamps
    end
  end
end
