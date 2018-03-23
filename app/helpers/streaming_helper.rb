module StreamingHelper
  def polymorphic_streaming_link(streaming)
    if controller_name == "live_streamings" || (controller_name == "home" && streaming.started?)
      live_streaming_path(streaming)
    else
      streaming_path(streaming)
    end
  end
end
