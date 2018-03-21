class LiveStreamingsController < ApplicationController
  def index
    @streamings = Streaming.where(status: :started)
    flash[:notice] = 'Ainda não há transmissões ao vivo' if !@streamings.present?
  end
end
