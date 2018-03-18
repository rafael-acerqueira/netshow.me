require 'rails_helper'

describe StreamingPresenter do


  describe '#status' do

    it 'humanize value' do
      user = login_admin
      streaming = create(:streaming, user: user, status: :started)
      presenter = described_class.new(streaming)
      expect(presenter.status).to eq 'Iniciado'
    end
  end
end
