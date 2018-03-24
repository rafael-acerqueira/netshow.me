class HomeController < ApplicationController
  def index
    @streamings = Streaming.select(:title, :slug, :date, :image, :user_id, :status).page params[:page]
    flash[:notice] = 'Ainda não há transmissões cadastradas' if !@streamings.present?
  end
end
