# frozen_string_literal: true

require 'capybara/cucumber'
require 'webdrivers'

Capybara.configure do |config|
  config.default_driver    = :selenium_chrome_headless
  config.javascript_driver = :selenium_chrome_headless
end
