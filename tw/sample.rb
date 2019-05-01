require 'json'
require 'active_support/all'
require 'yaml'

{"covers": { "tires": 10, "windows": 50, "engine": 20, "contents": 30, "doors": 15 }}

class CarInsurance
  def input
    @insurance_dictionary = YAML.load_file('./insurance.yml').with_indifferent_access
    get_in = gets.chomp()
    @user_input = HashWithIndifferentAccess.new(JSON.parse(get_in))[:covers]
    @user_input.sort_by { |key, value| value }.reverse.first(3)
  end

  def process_value
    result, final = input, Hash.new
    @insurance_dictionary[:insurer_rates].each do |insurer|
      text, sum = '', 0
      result.each do |u_res|
        insurer.last.split('+').each do |det|
          if det.downcase == u_res.first.downcase
            sum += u_res.last
            text += u_res.first+","
          end
        end
      end
      final.merge!("#{insurer.first}": text+"#{sum}")
    end
    final
  end

  def output_result
    output, final_result = process_value, Hash.new
    output.each_with_index do |key, index|
      total = key.last.split(',').last
      ins_covers = (key.last.split(',') - [total]).count
      final_result.merge!("#{key.first}": calculate_insurance(total.to_i, index+1, ins_covers))
    end
    puts final_result
  end

  private

  def calculate_insurance(value, position, count)
    calc_result = 0
    if position == 1
      calc_result = case count
      when 1
        (value*20/100.to_f)
      when 2
        (value*10/100.to_f)
      end
    end
    calc_result = (value*25/100.to_f) if position == 2
    calc_result = (value*35/100.to_f) if position == 3
    calc_result
  end
end

CarInsurance.new.output_result
