# "input": { "toolUsage": [ { "name": "knife", "useStartTime": "2017-01-30 10:00:00", "useEndTime": "2017-01-30 10:10:00" }, { "name": "guns", "useStartTime": "2017-01-30 10:15:00", "useEndTime": "2017-01-30 10:20:00" "output": { "toolsSortedOnUsage": [ { "name": "rope", "timeUsedInMinutes": 60 },

require './common.rb'
include Common
require 'time'

def process_response
  result = Hash.new
  final_result = []
  Common.get_input['toolUsage'].each_with_index do |key, index|
    puts key
    result[key['name']] = (result[key['name']] || 0) + ((Time.parse(key['useEndTime']) - Time.parse(key['useStartTime']))/60).to_i
  end
  r_result = result.sort_by { |name, timeUsedInMinutes| timeUsedInMinutes }.reverse
  r_result.each { |pr_result| final_result << ({name: pr_result.first, timeUsedInMinutes: pr_result.last }) }
  return final_result
end

def post_response
  output_value = process_response
  puts output_value.to_json
  options = { body: { toolsSortedOnUsage: output_value }.to_json,
    headers: { "userid" => "KEUCLDRJm", "content-type" => 'application/json' } }
  results = Common.post_output(options)
  puts results.body
end

post_response
