class TrelloReleasesController < InheritedResources::Base
  respond_to :json

  def create
    create! do |success, failure|
      success.json { render json: { id: @trello_release.id }, status: 201 }
      failure.json { render json: {}, status: 400 }
    end
  end

  def show
    show! do |success, failure|
      success.json { render json: { trello_release: @trello_release.to_json(include: :trello_cards)}, status: 200 }
      success.json { render json: {}, status: 404 }
    end
  end

  private

    def permitted_params
      params.permit(trello_release: [:release_date, trello_cards_attributes:[:card_number, :card_name, :card_link]])
    end
end
