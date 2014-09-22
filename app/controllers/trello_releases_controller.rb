class TrelloReleasesController < InheritedResources::Base

  private

    def permitted_params
      params.permit(trello_release: [:release_date, trello_cards_attributes:[:card_number, :card_name, :card_link]])
    end
end
