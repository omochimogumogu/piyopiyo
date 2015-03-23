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

  scenario 'ムービーが閲覧->変更までできる', js: true do
    movie1 = FactoryGirl.create(:movie, title: 'マトリックス', director: 'ウォシャウスキー兄弟', rate: 5)
    movie2 = FactoryGirl.create(:movie, title: '極道の妻', director: '五社英雄', rate: 4)

    visit '/movies'
    # 動画一覧ページへ遷移

    # save_and_open_screenshot

    find(:xpath, '/html/body/div[2]/div/div[1]/table/tbody/tr[2]/td[5]/a').click
    # 動画詳細ページへ遷移

    expect(page.current_path).to eq("/movies/#{movie1.id}")

    # save_and_open_screenshot

    click_link('Edit')
    # 動画編集ページへ遷移

    fill_in 'movie[title]', with: 'マトリックヌ'
    fill_in 'movie[director]', with: 'ウォシャウスキー姉妹'
    select '3', from: 'movie[rate]'

    click_link_or_button('Update Movie')
    # 動画詳細ページへ遷移

    # save_and_open_screenshot

    click_link('Back')
    # 動画一覧ページへ遷移

    # save_and_open_screenshot
  end

end
