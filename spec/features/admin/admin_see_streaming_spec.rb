require 'rails_helper'

feature 'Admin see streaming' do
  before(:each) do
    @user = login_admin
  end

  scenario 'successfully' do

    streaming = create(:streaming, user: @user)
    human_status = Streaming.human_attribute_name(streaming.status.to_sym)

    visit streaming_path(streaming)

    expect(page).to have_content streaming.title
    expect(page).to have_content streaming.description
    expect(page).to have_content streaming.date
    expect(page).to have_content streaming.user.name
    expect(page).to have_content human_status
    expect(page).to have_content streaming.url
    expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
    expect(page).to have_xpath("//a[contains(@class, 'start-stop')]")
  end
end
