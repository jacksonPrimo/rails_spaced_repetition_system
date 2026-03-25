class CardsController < ApplicationController
  before_action :authenticate_user!

  def next_card_to_review
    Card.where(
      "pack_id = ? AND user_id = ? AND next_review_at <= ?",
      params[:pack_id],
      current_user.id,
      Time.current + 10.minutes
    ).order(next_review_at: :desc).first
  end

  def review
    @pack = Pack.find_by(id: params[:pack_id], user_id: current_user.id)
    @card = next_card_to_review
  end

  def answer
    @card = Card.find_by(id: params[:id], user_id: current_user.id)
    @pack = Pack.find_by(id: params[:pack_id], user_id: current_user.id)

    case params[:answer]
    when 'facil'
      @card.update(next_review_at: 4.days.from_now, waiting_time: 4.days)
    when 'dificil'
      @card.update(next_review_at: 1.day.from_now, waiting_time: 1.day)
    when 'de_novo'
      @card.update(next_review_at: 1.minute.from_now, waiting_time: 1.minute)
    end

    redirect_to pack_review_path(@pack)
  end

  def create
    pack = Pack.find(params[:pack_id])
    new_card = Card.new(
      params.require(:card).permit(:front, :back, :context_phrase).merge(
        user_id: current_user.id,
        pack_id: pack.id,
        next_review_at: Time.now
      )
    )

    raise ::CustomException.new(
      message: "cannot register card: #{new_card.errors.to_a}", code: 400, redirect_path: pack_path(pack)
    ) unless new_card.save

    redirect_to pack_path(pack), notice: 'Cartão adicionado com sucesso!'
  end

  def list_cards_to_review
    cards = Card.where('next_review_at <= ?', Time.now).order(next_review_at: :asc)
    render json: cards
  end
end
