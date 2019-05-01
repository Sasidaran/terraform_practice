# "sampleInput": { "input": { "encryptedMessage": "F KFRTZX JCUQTWJW TSHJ XFNI, YMFY YMJ JCYWFTWINSFWD NX NS BMFY BJ IT, STY BMT BJ FWJ. LT JCUQTWJ!", "key": 5 } }, "sampleOutput": { "output": { "message": "A FAMOUS EXPLORER ONCE SAID, THAT THE EXTRAORDINARY IS IN WHAT WE DO, NOT WHO WE ARE. GO EXPLORE!" } }

require 'curb'
require './common.rb'
require 'active_support/all'
include Common

def process_response
  json_input, formatted_new_string = Common.get_input, []
  result = json_input['encryptedMessage'].bytes
  key = json_input['key']
  formatted_new_string = []
  result.each do |byt_k|
    if (65..90).to_a.include?(k)
      res = byt_k - key
      if res < 65
        comp = 65 - res
        formatted_new_string << 90 - (comp - 1)
      elsif res > 90
        comp = res - 90
        formatted_new_string << 65 + comp
      else
        formatted_new_string << res
      end
    else
      formatted_new_string << byt_k
    end
  end
  return formatted_new_string
end

def post_response
  output_result = process_response
  options = { body: { message: output_result.pack('c*') }.to_json,
    headers: { "userid" => "KEUCLDRJm", "content-type" => 'application/json' } }
  results = Common.post_output(options)

  puts results.body
end

post_response
# c = Curl::Easy.http_post("https://http-hunt.thoughtworks-labs.net/challenge/output", {message: formatted_new_string.pack('c*')}.to_json) do |c|
#    c.headers['userId'] = 'KEUCLDRJm'
#    c.headers["content-type"] = 'application/json'
# end

# puts c.body_str
