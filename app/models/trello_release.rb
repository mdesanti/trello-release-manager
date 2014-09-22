class TrelloRelease < ActiveRecord::Base
  has_many :trello_cards, dependent: :destroy

  accepts_nested_attributes_for :trello_cards
end
