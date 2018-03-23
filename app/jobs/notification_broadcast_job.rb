class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(streaming)
    ActionCable.server.broadcast "streaming_channel_to_#{streaming.slug}", message: render_notification(streaming)
  end

  private

  def render_notification(streaming)
    ApplicationController.renderer.render(partial: 'live_streamings/notification', locals: { streaming: streaming })
  end
end
