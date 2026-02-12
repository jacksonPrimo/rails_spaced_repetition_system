class PacksController < ApplicationController
  before_action :authenticate_user

  def index
    @packs = Pack.where(user_id: current_user.id)
  end

  def show
    @pack = Pack.find_by(user_id: current_user.id, id: params[:id])
    @total_cards = ::Card.where(pack_id: @pack.id).count
  end

  def new; end

  def edit
    @pack = Pack.find_by(user_id: current_user.id, id: params[:id])
  end

  def create
    new_pack = Pack.new(
      params.require(:pack).permit(:title).merge(user_id: current_user.id)
    )

    raise ::CustomException.new(
      message: "cannot register pack: #{new_pack.errors.to_a}", code: 400, redirect_path: '/packs/new'
    ) unless new_pack.save

    render_result new_pack, success_path: '/packs'
  end

  def update
    pack = Pack.find_by(id: params[:id], user_id: current_user.id)
    raise ::CustomException.new(
      message: 'Pack not found with this id', code: 404, redirect_path: '/packs/edit'
    ) unless pack.present?
    pack.update(params.require(:pack).permit(:title))
    render_result pack, success_path: '/packs'
  end

  def destroy
    pack = Pack.find_by(id: params[:id], user_id: current_user.id)
    raise ::CustomException.new(
      message: 'Pack not found with this id', code: 404, redirect_path: '/packs'
    ) unless pack.present?

    pack.delete

    render_result pack, success_path: '/packs'
  end
end
