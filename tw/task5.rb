require 'yaml'
require 'active_support/all'
require 'json'

sample_input = {"covers": { "tires": 10, "windows": 50, "engine": 20, "contents": 30, "doors": 15 }}

class CarInsurance
  # Public: Method to handle input varibales to be processed
  def input
    @insurance_details = YAML.load_file('./insurance.yml').with_indifferent_access
    inputs = gets.chomp()
    @input_to_treat = HashWithIndifferentAccess.new(JSON.parse(inputs))[:covers]
  end

  # Public: Method to process input params
  def process_input
    input
    result = Hash.new
    @covers_to_considered = @input_to_treat.sort_by {|key, value| value}.reverse.first(3)
    @insurance_details[:insurer_rates].each do |cover_details|
      text = ""
      sum = 0
      @covers_to_considered.each_with_index do |user_rate|
        cover_details.last.split('+').each do |c|
          if user_rate.first.downcase == c.downcase
            sum += user_rate.last
            text += user_rate.first+","
          end
        end
        result.merge!({ "#{cover_details.first}": text+"#{sum}" })
      end
    end
    result
  end

  # Public: Method to process the output
  def process_output
    result = process_input
    output = {}
    result.each_with_index do |key, index|
      output.merge!({"#{key.first}": interest_applied(key.last.split(',').last.to_i, index+1, 2)})
    end
    puts output
  end

  private

  def interest_applied(sum, position, count)
    if position == 1
      final_value = case count
      when 1
        (sum*20)/100.to_f
      when 2
        (sum*10)/100.to_f
      end
    end
    final_value = (sum*25)/100.to_f if position == 2
    final_value = (sum*30)/100.to_f if position == 3
    return final_value
  end
end

CarInsurance.new.process_output
