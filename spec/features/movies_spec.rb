require 'rails_helper'

feature 'ムービーが見れる', js: true do
  scenario 'ルートへ遷移するとmoviesへ行く' do
    visit '/'
    # save_and_open_screenshot
    expect(page.current_path).to eq('/movies')
    # save_and_open_page
  end

  scenario 'ムービーの登録ができる', js: true do
    visit '/'
    expect(page.current_path).to eq('/movies')
    find(:xpath, '/html/body/div[2]/div/div[1]/a').click
    expect(page.current_path).to eq('/movies/new')
    save_and_open_screenshot
    fill_in 'movie[title]', with: '良いタイトル'
    fill_in 'movie[director]', with: 'イイ監督'
    select '4', from: 'movie[rate]'
    save_and_open_screenshot
    find(:xpath, '//*[@id="new_movie"]/div[5]/input').click
    save_and_open_screenshot
  end
end
