# {"sampleInput"=>{"input"=>{"tools"=>[{"name"=>"knife", "weight"=>1, "value"=>80}, {"name"=>"guns", "weight"=>5, "value"=>90}, {"name"=>"rope", "weight"=>10, "value"=>60}, {"name"=>"water", "weight"=>8, "value"=>40}], "maximumWeight"=>15}}, "sampleOutput"=>{"output"=>{"toolsToTakeSorted"=>["guns", "knife", "water"]}}}

require './common.rb'
require 'active_support/all'
include Common

def process_response
  json_input, output_result, final_result, sum_value = Common.get_input, [], [], 0
  @input = HashWithIndifferentAccess.new(json_input)
  @input[:tools].sort_by { |hsh| hsh[:value] }.reverse.each do |tool|
   if tool[:weight] < @input[:maximumWeight]
     sum_value += tool[:weight]
     if (sum_value) > @input[:maximumWeight]
       sum_value -= tool[:weight]
     else
       output_result << { name: tool[:name], value: tool[:value] } if (sum_value) <= @input[:maximumWeight]
     end
   end
  end
  output_result.sort_by { |hsh| hsh[:value] }.reverse.each { |pr| final_result << pr[:name] }
  return final_result
end


def process_output
  output_value = process_response
  options = { body: { toolsToTakeSorted: output_value }.to_json,
    headers: { "userid" => "KEUCLDRJm", "content-type" => 'application/json' } }
  results = Common.post_output(options)
  puts results.body
end

process_output
