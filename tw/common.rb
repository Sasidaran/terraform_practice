require 'httparty'
require 'json'
module Common
  @headers = { "userId" => "KEUCLDRJm" }

  def self.get_input
    response = HTTParty.get('https://http-hunt.thoughtworks-labs.net/challenge/input', headers: @headers)
    result = JSON.parse(response.body)
    return result
  end

  def self.post_output(options)
    HTTParty.post("https://http-hunt.thoughtworks-labs.net/challenge/output", options)
  end

  def self.get_challenge
    response = HTTParty.get('https://http-hunt.thoughtworks-labs.net/challenge', headers: @headers)
    result = JSON.parse(response.body)
    return result
  end
end
