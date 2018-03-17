class StreamingsController < ApplicationController

  before_action :streaming, only: :show

  def new
    @streaming = Streaming.new
  end

  def create
    @streaming = current_user.streamings.build(streaming_params)
    if @streaming.save
      redirect_to @streaming
    else
      flash[:error] = 'A transmissão não pode ser cadastrada, verifique os dados'
      render :new
    end
  end

  def show

  end


  private

  def streaming
    @streaming = Streaming.find_by_slug(params[:id])
  end

  def streaming_params
    params.require(:streaming).permit(:title, :description, :image, :date, :url)
  end
end
