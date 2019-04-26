require 'httparty'

# @headers = { "userId" => "KEUCLDRJm" }
#
# def get_response
#   response = HTTParty.get('https://http-hunt.thoughtworks-labs.net/challenge/input', headers: @headers)
#   result = JSON.parse(response.body)
#   puts result['encryptedMessage']
#   return result
# end
# query = get_response
#
# body_r = { encryptedMessage: query['encryptedMessage'], key: query['key'] }.to_json
# pt_response = HTTParty.post('https://http-hunt.thoughtworks-labs.net/challenge/output', headers: { "userid" => "KEUCLDRJm", "content-type" => 'application/json' }, query: query)
# puts pt_response.body
#
# def post_response
#   query = get_response
#   options = { :body =>
#     { :encryptedMessage => query['encryptedMessage'],
#       :key => query['key']
#     }.to_json,
#     headers: { "userid" => "KEUCLDRJm", "content-type" => 'application/json' }
#   }
#   results = HTTParty.post("https://http-hunt.thoughtworks-labs.net/challenge/output", options)
#
#   puts results.body
#   # HTTParty.post("https://http-hunt.thoughtworks-labs.net/challenge/output",
#   #      headers: { "userid" => "KEUCLDRJm", "content-type" => 'application/json' },
#   #      body: { "encryptedMessage" => query['encryptedMessage'], "key" => query['key'] }.to_json)
# end
#
# post_response


puts '###################'

require 'net/http'
require 'uri'
require 'json'

get_challenge = URI.parse('https://http-hunt.thoughtworks-labs.net/challenge')
http = Net::HTTP.new(get_challenge.host, get_challenge.port)
http.use_ssl = true
header = { "userId" => "KEUCLDRJm", 'Content-Type': 'application/json' }
c_req = Net::HTTP::Get.new(get_challenge.request_uri, header)

c_response = http.request(c_req)
c_body = JSON.parse(c_response.body)
puts c_body

url = URI.parse('https://http-hunt.thoughtworks-labs.net/challenge/input')
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
header = { "userId" => "KEUCLDRJm", 'Content-Type': 'application/json' }
req = Net::HTTP::Get.new(url.request_uri, header)

response = http.request(req)
body = JSON.parse(response.body)

puts body['encryptedMessage']

uri = URI.parse("https://http-hunt.thoughtworks-labs.net/challenge/output")
post_http = Net::HTTP.new(uri.host, uri.port)
post_http.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri, header)
puts uri.request_uri
puts uri

request.body = { "encryptedMessage" => body['encryptedMessage'], "key" => body['key'] }.to_json

post_response = post_http.request(request)

puts post_response.body
