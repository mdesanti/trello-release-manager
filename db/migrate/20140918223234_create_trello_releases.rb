class CreateTrelloReleases < ActiveRecord::Migration
  def change
    create_table :trello_releases do |t|
      t.datetime :release_date

      t.timestamps
    end
  end
end
