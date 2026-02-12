class CardsController < ApplicationController
  before_action :authenticate_user

  def create
    pack = Pack.find(params[:pack_id])
    new_card = Card.new(
      params.require(:card).permit(:front, :back, :context_phrase).merge(
        user_id: current_user.id,
        pack_id: pack.id,
        show_at: Time.now
      )
    )

    raise ::CustomException.new(
      message: "cannot register card: #{new_card.errors.to_a}", code: 400, redirect_path: pack_path(pack)
    ) unless new_card.save

    redirect_to pack_path(pack), notice: 'Cartão adicionado com sucesso!'
  end
end
