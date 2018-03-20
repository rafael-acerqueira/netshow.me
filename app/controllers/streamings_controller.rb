class StreamingsController < ApplicationController
  load_and_authorize_resource
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
    @streaming = StreamingPresenter.new(@streaming)
  end

  def index
    @q = Streaming.ransack(params[:q])
    @streamings = @q.result
    flash[:notice] = 'Ainda não há transmissões cadastradas' if !@streamings.present?
    @users = User.all
    @status = statuses
  end

  private

  def streaming

    @streaming = Streaming.find_by_slug(params[:id])
  end

  def streaming_params
    params.require(:streaming).permit(:title, :description, :image, :date, :url)
  end

  def statuses
    Streaming.statuses.map do |key, value|
      [Streaming.human_attribute_name(key.to_sym), value]
    end
  end
end
