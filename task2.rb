# "sampleInput": { "input": { "hiddenTools": "opekandifehgujnsr", "tools": [ "knife", "guns", "rope" ] } }, "sampleOutput": { "output": { "toolsFound": [ "knife", "guns" ] } }
require './common.rb'
include Common

def request_processing
  result = []
  @query['tools'].each do |tools|
    count = 0
    tools.chars.each do |t_char|
      count +=1 if @query['hiddenTools'].chars.include?(t_char)
    end
    result << tools if tools.length == count
  end
  return result
end

def post_response
  @query = Common.get_input
  processed_result = request_processing
  options = { body: { toolsFound: processed_result }.to_json,
    headers: { "userid" => "KEUCLDRJm", "content-type" => 'application/json' } }
  results = Common.post_output(options)

  puts results.body
end

post_response
