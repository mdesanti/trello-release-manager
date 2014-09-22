class TrelloCard < ActiveRecord::Base
  belongs_to :trello_release
end
