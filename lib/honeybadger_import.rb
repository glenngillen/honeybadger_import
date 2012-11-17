require "honeybadger_import/version"
require "airbrake-api"
require "honeybadger"

module HoneybadgerImport
  def self.migrate(airbrake_account, airbrake_auth_token, honeybadger_key)
    AirbrakeAPI.configure(:account => airbrake_account, :auth_token => airbrake_auth_token, :secure => true)
    Honeybadger.configure do |config|
      config.api_key = honeybadger_key
    end
    errors = []
    page = 1
    retries = 0
    begin
      while airbrake_errors = AirbrakeAPI.errors(:page => page) do
        puts "Doing page #{page} of errors..."
        errors += airbrake_errors.map do |error|
          airbrake_error = AirbrakeAPI.error(error.id).to_hash.symbolize_keys
          airbrake_error[:backtrace] = airbrake_error[:backtrace]["line"]
          airbrake_error
        end
        page += 1
      end
    rescue Faraday::Error::ParsingError => e
      puts "Boooo!! Faraday error"
      retries += 1
      retry if retries < 5
    end
    errors.each do |error|
      Honeybadger.notify(error)
    end
  end
end
