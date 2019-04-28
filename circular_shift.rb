require './helpers/bit_helper'
require 'optparse'
require 'English'

options = {}
# OptionParser for more meaningful command line help
optparse = OptionParser.new do |parser|
  parser.on(
    '-n',
    '--number NUMBER',
    Integer,
    'the NUMBER to be circular shifted'
  ) do |number|
    options[:number] = number
  end

  parser.on(
    '-b',
    '--bits INTEGER_BITS',
    Integer,
    'the INTEGER BITS of the NUMBER'
  ) do |bits|
    options[:bits] = bits
  end

  parser.on(
    '-s',
    '--steps STEPS',
    Integer,
    'the number of STEPS that the NUMBER will be circular shifted'
  ) do |steps|
    options[:steps] = steps
  end

  parser.on(
    '-d',
    '--direction DIRECTION',
    String,
    'the DIRECTION that the NUMBER will be circular shifted'
  ) do |direction|
    options[:direction] = direction
  end
end.parse!

# check the required arguments
begin
  optparse.parse!
  mandatory = %i(number bits steps direction)
  missing = mandatory.select { |param| options[param].nil? }
  raise OptionParser::MissingArgument, missing.join(', ') unless missing.empty?
rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  puts $ERROR_INFO.to_s
  puts optparse
  exit
end

number = options[:number]
int_bits = options[:bits]
steps = options[:steps]
case options[:direction]
when 'left' # rotate bits to the left
  puts '----------------------------------------------------------'
  puts 'Number            : ' + number.to_s
  puts 'Number in binary  : ' + BitHelper.number_to_bits(number, int_bits)
  result = BitHelper.circular_shift_left(number, int_bits, steps)
  puts 'Result            : ' + result.to_s
  puts 'Result in binary  : ' + BitHelper.number_to_bits(result, int_bits)
  puts '----------------------------------------------------------'
when 'right' # rotate bits to the right
  puts '----------------------------------------------------------'
  puts 'Number            : ' + number.to_s
  puts 'Number in binary  : ' + BitHelper.number_to_bits(number, int_bits)
  result = BitHelper.circular_shift_right(number, int_bits, steps)
  puts 'Result            : ' + result.to_s
  puts 'Result in binary  : ' + BitHelper.number_to_bits(result, int_bits)
  puts '----------------------------------------------------------'
else # error
  raise OptionParser::InvalidArgument, "DIRECTION only takes 'left' or 'right'"
end
