class CreateTrelloCards < ActiveRecord::Migration
  def change
    create_table :trello_cards do |t|
      t.integer :card_number
      t.string :card_name
      t.string :card_link
      t.references :trello_release, index: true

      t.timestamps
    end
  end
end
