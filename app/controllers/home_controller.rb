class HomeController < ApplicationController
  def index
    @streamings = Streaming.page params[:page]
    flash[:notice] = 'Ainda não há transmissões cadastradas' if !@streamings.present?
  end
end
