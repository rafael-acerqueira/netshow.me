class StreamingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "streaming_channel_to_#{params[:slug]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
