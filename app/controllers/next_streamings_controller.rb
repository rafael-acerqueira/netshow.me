class NextStreamingsController < ApplicationController
  def index
    @streamings = Streaming.select(:title, :slug, :date, :image, :user_id, :status).where('date > ?', Date.today).page params[:page]
    flash[:notice] = 'Ainda não há transmissões futuras' if !@streamings.present?
  end
end
