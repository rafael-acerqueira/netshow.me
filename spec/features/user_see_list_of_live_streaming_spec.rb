require 'rails_helper'

feature 'User see list of live streaming' do

  before(:each) do
    @user = login
  end

  scenario 'successfully' do
    admin_role = create(:role, name: 'admin')
    admin_user = create(:user, role: admin_role)

    live_streaming = create(:streaming, user: admin_user, status: :started)

    new_streaming = create(:streaming, user: admin_user)

    visit live_streamings_path

    within('.streaming-item-0') do
      expect(page).to have_content live_streaming.title
      expect(page).to have_content I18n.l live_streaming.date
      expect(page).to have_content live_streaming.user.name
      expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
      expect(page).to have_selector(:css, 'a[href="'+live_streaming_path(live_streaming)+'"]')
    end

    expect(page).to_not have_selector(:css, '.streaming-item-1')

  end

  scenario 'Without records' do

    visit live_streamings_path

    expect(page).to have_content 'Ainda não há transmissões ao vivo'
  end
end
