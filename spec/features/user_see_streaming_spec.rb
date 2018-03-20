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
      expect(page).to have_content streaming.date
      expect(page).to have_content streaming.user.name
      expect(page).to have_content human_status
      expect(page).to have_content streaming.url
      expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
      expect(page).to have_xpath("//a[contains(@class, 'start-stop')]")
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
