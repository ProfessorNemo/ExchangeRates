# frozen_string_literal: true

class CreateExchangeRates < ActiveRecord::Migration[7.0]
  def up
    create_table :exchange_rates do |t|
      t.integer :currency, null: false
      t.datetime :rate_at, null: false
      t.float :rate_value, null: false

      t.timestamps
    end

    add_index :exchange_rates, %i[currency rate_at rate_value], unique: true
  end

  def down
    remove_index :exchange_rates, %i[currency rate_at rate_value]

    drop_table :exchange_rates
  end
end
