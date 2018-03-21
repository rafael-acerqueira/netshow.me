include ActionDispatch::TestProcess
FactoryBot.define do
  factory :streaming do
    title FFaker::Book.title
    description FFaker::Lorem.phrases
    date Date.today
    image { fixture_file_upload(Rails.root + "spec/fixtures/image.png", "image/png") }
    url "https://content.jwplatform.com/manifests/yp34SRmf.m3u8"
    status Streaming.statuses[:confirmed]
    user
  end
end
