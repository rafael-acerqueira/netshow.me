class LiveStreamingsController < ApplicationController

  before_action :started_streaming, only: [:index, :show]

  def index
    @streamings = @streamings.select(:title, :slug, :date, :image, :user_id, :status).page params[:page]
    flash[:notice] = 'Ainda não há transmissões ao vivo' if !@streamings.present?
  end

  def show
    @streaming = @streamings.select(:title, :slug, :description, :date, :image, :url, :user_id).find_by_slug(params[:slug])
    redirect_to live_streamings_url if !@streaming.present?
  end



  private

  def started_streaming
    @streamings = Streaming.where(status: :started)
  end
end
