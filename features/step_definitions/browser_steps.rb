# frozen_string_literal: true

When("ブラウザのウィンドウを {int}px × {int}px にリサイズする") do |width, height|
  page.driver.browser.manage.window.resize_to(width, height)
end

Then("スクリーンショットを撮って{string}に保存する") do |file_path|
  page.save_screenshot "tmp/#{file_path}"
end
