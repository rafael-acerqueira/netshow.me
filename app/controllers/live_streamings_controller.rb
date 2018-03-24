class LiveStreamingsController < ApplicationController

  before_action :started_streaming, only: [:index, :show]

  def index
    @streamings = @streamings.page params[:page]
    flash[:notice] = 'Ainda não há transmissões ao vivo' if !@streamings.present?
  end

  def show
    @streaming = @streamings.find_by_slug(params[:slug])
    redirect_to live_streamings_url if !@streaming.present?
  end



  private

  def started_streaming
    @streamings = Streaming.where(status: :started)
  end
end
