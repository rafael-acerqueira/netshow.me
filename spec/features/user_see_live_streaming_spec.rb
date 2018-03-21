require 'rails_helper'

feature 'User see live streaming' do
  before(:each) do
    login
  end

  scenario 'successfully' do
    admin_role = create(:role, name: 'admin')
    admin_user = create(:user, role: admin_role)
    streaming = create(:streaming, user: admin_user, status: :started)

    visit live_streaming_path(streaming)

    expect(page).to have_content streaming.title
    expect(page).to have_content streaming.description
    expect(page).to have_content streaming.date
    expect(page).to have_content streaming.user.name
    expect(page).to have_xpath ("//source[contains(@src, '#{streaming.url}')]")
    expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
  end

  scenario 'and cannot access' do
    admin_role = create(:role, name: 'admin')
    admin_user = create(:user, role: admin_role)
    streaming = create(:streaming, user: admin_user)

    visit live_streaming_path(streaming)

    expect(page).to have_current_path(live_streamings_path)
  end
end
