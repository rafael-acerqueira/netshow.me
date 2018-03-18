class StreamingPresenter < SimpleDelegator
  def status
    Streaming.human_attribute_name(__getobj__.status.to_sym)
  end
end
