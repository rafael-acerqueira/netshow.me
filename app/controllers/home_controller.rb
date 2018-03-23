class HomeController < ApplicationController
  def index
    @streamings = Streaming.all
    flash[:notice] = 'Ainda não há transmissões cadastradas' if !@streamings.present?
  end
end
