require 'pry'
require 'yaml'
MESSAGES = YAML.load_file('loan_calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang = 'en')
  MESSAGES[lang][message]
end

def prompt(message)
  puts message.to_s
end

loop do
  prompt(messages('fancy_spacer'))
  prompt(messages('welcome'))
  prompt(messages('fancy_spacer'))
  puts ''

  loan_amount = ''
  loop do
    prompt(messages('loan_amount'))
    prompt(messages('loan_amount_format'))
    puts ''
    loan_amount = gets.chomp.to_f

    if loan_amount <= 0 || loan_amount.nil?
      prompt(messages('input_error'))
    else
      break
    end
  end

  apr = ''
  loop do
    puts ''
    prompt(messages('apr'))
    prompt(messages('apr_format'))
    puts ''
    apr = gets.chomp.to_f

    if apr <= 0 || apr.nil?
      puts ''
      prompt(messages('input_error'))
    else
      break
    end
  end

  loan_length = ''
  loop do
    puts ''
    prompt(messages('loan_length'))
    prompt(messages('loan_length_format'))
    puts ''
    loan_length = gets.chomp.to_f

    if loan_length <= 0 || loan_length.nil?
      puts ''
      prompt(messages('input_error'))
    else
      break
    end
  end

  annual_interest = apr / 100
  monthly_interest = annual_interest / 12

  m = loan_amount * (monthly_interest / (1 - (1 +
    monthly_interest)**-loan_length))

  puts ''
  prompt(messages('fancy_spacer'))
  prompt(messages('loan_summary'))
  puts "Your loan is in the amount of $#{format('%02.2f', loan_amount)}."
  puts "Your APR is #{apr}%."
  puts "The duration of your loan is #{(loan_length / 12).round(2)} years."
  puts ''
  prompt(messages('monthly_payment'))
  puts ''
  puts "*** $#{format('%02.2f', m)} ***"
  puts ''
  prompt(messages('fancy_spacer'))
  puts ''
  prompt(messages('calculate_again'))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

puts ''
prompt(messages('goodbye'))
puts ''
