require 'rails_helper'

feature 'User see list of next streamings' do

  before(:each) do
    login
  end

  scenario 'successfully' do
    admin_role = create(:role, name: 'admin')
    admin_user = create(:user, role: admin_role)

    old_streaming = create(:streaming, user: admin_user, status: :confirmed,
                                       date: Date.yesterday)

    new_streaming = create(:streaming, user: admin_user, status: :confirmed,
                                       date: Date.tomorrow)

    visit next_streamings_path

    within('.streaming-item-0') do
      expect(page).to have_content new_streaming.title
      expect(page).to have_content I18n.l new_streaming.date
      expect(page).to have_content new_streaming.user.name
      expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
      expect(page).to have_selector(:css, 'a[href="'+streaming_path(new_streaming)+'"]')
    end

    expect(page).to_not have_selector(:css, '.streaming-item-1')

  end

  scenario 'Without records' do

    visit next_streamings_path

    expect(page).to have_content 'Ainda não há transmissões futuras'
  end
end
