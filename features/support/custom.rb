#since the env.rb file is autogenerated, I'm adding my own stuff here.

#@driver_name = ENV['DRIVER'] || "poltergeist"
#Capybara.javascript_driver = @driver_name.to_sym
#Capybara.app_host = ENV['HOST'] || "http://x:x"

require 'rspec' #for page.shoud etc
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'pry'
require 'capybara-screenshot'
require 'capybara-screenshot/cucumber'
require 'firefox'

#Capybara.register_driver :chrome do |app|
#  Capybara::Selenium::Driver.new(app, :browser => :chrome)
#end

require "selenium/webdriver"


# Clean the database before and after each scenario
Before do
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
end

Capybara.register_driver :firefox do |app|
  	Capybara::Selenium::Driver.new(app, :browser=>:firefox)

  	# Selenium::WebDriver::Firefox::Binary.path = ENV['CUSTOM_FF_PATH'] if ENV['CUSTOM_FF_PATH'].present?
	profile = Selenium::WebDriver::Firefox::Profile.new
	# profile.assume_untrusted_certificate_issuer = ENV['SKIP_CERT_ISSUER'].present?
	profile['browser.download.dir'] = Rails.root.join("tmp/downloads").to_s
	profile['browser.download.folderList'] = 2 # implies custom location
	#profile['browser.helperApps.neverAsk.saveToDisk'] = "*"
	profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv,application/pdf,application/doc,application/docx,image/jpeg"
	profile.native_events = true
	Capybara::Selenium::Driver.new(app, :browser => :firefox ,:profile => profile)
	   #Capybara::Selenium::Driver.new app, :profile => profile
end

Capybara.register_driver :chrome do |app|
  #profile = Selenium::WebDriver::Chrome::Profile.new
  #profile["download.default_directory"] = DownloadHelpers::PATH.to_s
  #profile["download.default_directory"] = Rails.root.join("tmp/downloads")
  #Capybara::Selenium::Driver.new(app, :browser => :chrome, :profile => profile)
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :phantomjs do |app|
  Capybara::Selenium::Driver.new(app, :browser => :phantomjs)
end

Capybara.javascript_driver = :poltergeist
#Capybara.default_driver = :chrome
#Capybara.javascript_driver = :firefox

=begin
Capybara.register_driver :chrome do |app|
  profile = Selenium::WebDriver::Chrome::Profile.new
  #profile["download.default_directory"] = DownloadHelpers::PATH.to_s
  profile["download.default_directory"] = Rails.root.join("tmp/downloads")
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :profile => profile)
end

Capybara.server_port = 1337

Capybara.default_driver = Capybara.javascript_driver = :chrome
Capybara.app_host = "http://localhost:" + Capybara.server_port.to_s
=end

#Capybara.default_driver = :chrome

#Capybara.default_driver = ENV['WEB_DRIVER'] || :selenium
#Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 10
