def validate_password(requirements, password)
  required_letter, range = requirements.split
  min_count, max_count = range.split('-').map(&:to_i)
  letter_count = password.count(required_letter)
  letter_count.between?(min_count, max_count)
end

def count_passwords(path)
  quantity_of_valid_passwords = 0

  File.open(path).each_line do |line|
    requirements, password = line.split(':')
    requirements.strip!
    password.strip!

    quantity_of_valid_passwords += 1 if validate_password(requirements, password)
  end

  quantity_of_valid_passwords
end

def start_testing(checkpoint_to_end)
  puts 'Enter file path'
  file_path = gets.chomp
  puts '-------------------------------------'

  if File.exist?(file_path)
    quantity_of_valid_passwords = count_passwords(file_path)
    puts "Quantity of valid passwords: #{quantity_of_valid_passwords}"
  else
    puts "File path isn't correct"
  end
  puts '-------------------------------------'
  sleep(0.75)

  puts('Check next file(1)')
  puts('End(Enter another key)')
  checkpoint_to_continue = gets.chomp.to_i
  puts '-------------------------------------'

  checkpoint_to_end = true if checkpoint_to_continue != 1

  checkpoint_to_end
end

puts 'Start(1)'
puts 'End(Enter another key)'
key = gets.chomp
puts '-------------------------------------'

checkpoint_to_end = key != '1'

checkpoint_to_end = start_testing(checkpoint_to_end) while checkpoint_to_end != true
