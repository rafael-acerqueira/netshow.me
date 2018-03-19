require 'rails_helper'

feature 'Admin see list of streamings' do
  before(:each) do
    @user = login_admin
  end

  scenario 'successfully' do

    streamings = create_list(:streaming, 5, user: @user)

    visit streamings_path

    within('.streaming-item:nth-child(3)') do
      expect(page).to have_content streamings.third.title
      expect(page).to have_content I18n.l streamings.third.date
      expect(page).to have_content streamings.third.user.name
      expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
      expect(page).to have_selector(:css, 'a[href="'+streaming_path(streamings.third)+'"]')
    end
    
  end

  scenario 'With invalid data' do

    visit streamings_path

    expect(page).to have_content 'Ainda não há transmissões cadastradas'
  end
end
