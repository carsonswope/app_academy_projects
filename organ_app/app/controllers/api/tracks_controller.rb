class Api::TracksController < ApplicationController
  def index
    render json: Track.all
  end

  def create
    track = Track.create!(name: params[:track][:name], roll: params[:track][:roll])
    render json: track
  end

  def destroy
    track = Track.find_by_id(params[:id])
    track.destroy!
    render json: track
  end

end
