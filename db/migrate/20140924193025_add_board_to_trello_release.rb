class AddBoardToTrelloRelease < ActiveRecord::Migration
  def change
    add_column :trello_releases, :board, :string
  end
end
