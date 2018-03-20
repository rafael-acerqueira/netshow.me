require 'rails_helper'

feature 'User see list of streamings' do

  feature 'is admin' do
    before(:each) do
      @user = login_admin
    end

    scenario 'successfully' do

      streamings = create_list(:streaming, 5, user: @user)

      visit streamings_path

      within('.streaming-item-1') do
        expect(page).to have_content streamings.second.title
        expect(page).to have_content I18n.l streamings.second.date
        expect(page).to have_content streamings.second.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to have_selector(:css, 'a[href="'+streaming_path(streamings.second)+'"]')
      end

    end

    scenario 'User see list of streamings and filter it by one field' do

      first_streaming = create(:streaming, user: @user, title: 'Streaming 1')
      second_streaming = create(:streaming, user: @user, title: 'Streaming 2')

      visit streamings_path

      fill_in 'q_title_cont', with: second_streaming.title
      find('button[name="button"]').click

      within('.streaming-item-0') do
        expect(page).to have_content second_streaming.title
        expect(page).to have_content I18n.l second_streaming.date
        expect(page).to have_content second_streaming.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to have_selector(:css, 'a[href="'+streaming_path(second_streaming)+'"]')
      end

      expect(page).to_not have_selector(:css, '.streaming-item-1')

    end

    scenario 'User see list of streamings and filter it by two fields' do

      first_streaming = create(:streaming, user: @user,
                              title: 'Streaming 1', status: :done)
      second_streaming = create(:streaming, user: @user,
                                title: 'Streaming 2', status: :started)

      second_streaming = StreamingPresenter.new(second_streaming)

      visit streamings_path

      fill_in 'q_title_cont', with: second_streaming.title
      select  second_streaming.status, from: 'q_status_eq'
      find('button[name="button"]').click

      within('.streaming-item-0') do
        expect(page).to have_content second_streaming.title
        expect(page).to have_content I18n.l second_streaming.date
        expect(page).to have_content second_streaming.user.name
        expect(page).to have_xpath("//img[contains(@src,'/uploads/streamings/image/')]")
        expect(page).to have_selector(:css, 'a[href="'+streaming_path(second_streaming)+'"]')
      end

      expect(page).to_not have_selector(:css, '.streaming-item-1')

    end

    scenario 'With invalid data' do

      visit streamings_path

      expect(page).to have_content 'Ainda não há transmissões cadastradas'
    end
  end

  feature 'is not admin' do
    scenario 'user is redirect_to home page' do
      user = login
      admin_role = create(:role, name: 'admin')
      admin_user = create(:user, role: admin_role)

      streamings = create_list(:streaming, 2, user: admin_user)

      visit streamings_path

      expect(page).to have_current_path(root_url)
    end
  end
end
