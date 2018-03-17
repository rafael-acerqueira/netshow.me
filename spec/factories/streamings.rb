FactoryBot.define do
  factory :streaming do
    title FFaker::Book.title
    description FFaker::Lorem.phrases
    date Date.today
    image "https://robohash.org/aututquod.png?size=300x300"
    url "https://content.jwplatform.com/manifests/yp34SRmf.m3u8"
    status 0
    user
  end
end
