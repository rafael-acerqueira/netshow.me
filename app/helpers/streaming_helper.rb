module StreamingHelper
  def polymorphic_streaming_link(streaming)
    if controller_name == "live_streamings"
      live_streaming_path(streaming)
    else
      streaming_path(streaming)
    end
  end
end
