# frozen_string_literal: true

class CreateMarketLists < ActiveRecord::Migration[6.1]
  def change
    create_table :market_lists do |t|
      t.string :name
      t.date :market_date, null: false
      t.timestamps
    end
  end
end
