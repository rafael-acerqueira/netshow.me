require 'rails_helper'

feature 'User see streaming' do

  feature 'is admin' do
    scenario 'successfully' do
      user = login_admin
      streaming = create(:streaming, user: user)
      human_status = Streaming.human_attribute_name(streaming.status.to_sym)

      visit streaming_path(streaming)

      expect(page).to have_content streaming.title
      expect(page).to have_content streaming.description
      expect(page).to have_content I18n.l streaming.date
      expect(page).to have_content streaming.user.name
      expect(page).to have_content human_status
      expect(page).to have_content streaming.url
      expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
      expect(page).to have_xpath("//input[contains(@class, 'start-streaming')]")
      expect(page).to have_xpath("//input[contains(@class, 'stop-streaming')]")
    end

    scenario 'and start streaming' do
      user = login_admin
      streaming = create(:streaming, user: user)

      previous_status = streaming.status

      visit streaming_path(streaming)

      click_on I18n.t('start_streaming')

      status_updated = streaming.reload.status

      expect(page).to have_current_path(streaming_path(streaming))
      expect(status_updated).to_not eq previous_status
      expect(status_updated.to_sym).to equal :started

      expect(page).to have_content 'Transmissão Iniciada'

    end

    scenario 'and finish streaming' do
      user = login_admin
      streaming = create(:streaming, user: user)

      previous_status = streaming.status

      visit streaming_path(streaming)

      click_on I18n.t('finish_streaming')

      status_updated = streaming.reload.status

      expect(page).to have_current_path(streaming_path(streaming))
      expect(status_updated).to_not eq previous_status
      expect(status_updated.to_sym).to equal :done

      expect(page).to have_content 'Transmissão Finalizada'

    end
  end

  feature 'is not admin' do

    scenario 'user is redirect_to home page' do
      user = login
      admin_role = create(:role, name: 'admin')
      admin_user = create(:user, role: admin_role)

      streaming = create(:streaming, user: admin_user, status: :confirmed)

      visit streaming_path(streaming)

      expect(page).to have_current_path(root_url)
    end
  end
end
