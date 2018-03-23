require 'rails_helper'

feature 'User see all streamings at homepage' do

  feature 'is admin' do

    scenario 'successfully' do
      user = login_admin

      first_streaming = create(:streaming, user: user, status: :confirmed)
      second_streaming = create(:streaming, user: user, status: :started)
      third_streaming = create(:streaming, user: user, status: :done)

      visit root_path

      within('.streaming-item-0') do
        expect(page).to have_content first_streaming.title
        expect(page).to have_content I18n.l first_streaming.date
        expect(page).to have_content first_streaming.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to have_selector(:css, 'a[href="'+streaming_path(first_streaming)+'"]')
      end

      within('.streaming-item-1') do
        expect(page).to have_content second_streaming.title
        expect(page).to have_content I18n.l second_streaming.date
        expect(page).to have_content second_streaming.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to have_selector(:css, 'a[href="'+live_streaming_path(second_streaming)+'"]')
      end

      within('.streaming-item-2') do
        expect(page).to have_content third_streaming.title
        expect(page).to have_content I18n.l third_streaming.date
        expect(page).to have_content third_streaming.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to have_selector(:css, 'a[href="'+streaming_path(third_streaming)+'"]')
      end

    end
  end

  feature 'is not admin' do

    scenario 'successfully' do
      login
      admin_role = create(:role, name: 'admin')
      admin_user = create(:user, role: admin_role)

      first_streaming = create(:streaming, user: admin_user, status: :confirmed)
      second_streaming = create(:streaming, user: admin_user, status: :started)
      third_streaming = create(:streaming, user: admin_user, status: :done)

      visit root_path

      within('.streaming-item-0') do
        expect(page).to have_content first_streaming.title
        expect(page).to have_content I18n.l first_streaming.date
        expect(page).to have_content first_streaming.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to_not have_selector(:css, 'a[href="'+streaming_path(first_streaming)+'"]')
      end

      within('.streaming-item-1') do
        expect(page).to have_content second_streaming.title
        expect(page).to have_content I18n.l second_streaming.date
        expect(page).to have_content second_streaming.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to have_selector(:css, 'a[href="'+live_streaming_path(second_streaming)+'"]')
      end

      within('.streaming-item-2') do
        expect(page).to have_content third_streaming.title
        expect(page).to have_content I18n.l third_streaming.date
        expect(page).to have_content third_streaming.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to_not have_selector(:css, 'a[href="'+streaming_path(third_streaming)+'"]')
      end

    end
  end

  scenario 'Without records' do
    login
    visit root_path

    expect(page).to have_content 'Ainda não há transmissões cadastradas'
  end
end
