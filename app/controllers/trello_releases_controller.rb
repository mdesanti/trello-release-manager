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

  def for_board
    releases = TrelloRelease.where(board: params[:board_id]).order('created_at DESC')
    render json: { trello_releases: releases.to_json }, status: 200
  end

  private

    def permitted_params
      params.permit(trello_release: [:release_date, :board, trello_cards_attributes:[:card_number, :card_name, :card_link]])
    end
end
