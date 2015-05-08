# FILE = File.expand_path(File.join(File.dirname(__FILE__), '..', 'dictionary.txt'))
# WORDS = File.open(FILE).select { |w| w =~ /^\w+$/ }.map(&:chomp)
FILE = File.expand_path(File.join(File.dirname(__FILE__), '..', 'd.txt'))
WORDS = File.open(FILE).select { |w| w =~ /^\w+$/ }.map(&:chomp)
DICTIONARY = dictionary(WORDS)

def dictionary(array, index = 0)
  res = array.group_by{|i| i[index].downcase}
  dictionary = {}
  index = index + 1
  res.each do |key, value|
    dictionary[key] = value.group_by{|i| i[index].downcase}
  end
  dictionary
  end
end

module PhoneConverter
  CHARS_MAP = {"2" => "ABC", "3" => "DEF", "4" => "GHI", "5" => "JKL", "6" => "MNO", "7" => "PQRS", "8" => "TUV", "9" => "WXYZ" }

  def self.convert(phone)
    [].tap do |mem|
      _convert(phone, mem)
    end
  end

  private

  def self._convert(chars, mem, buffer = '')
    char = chars[buffer.size]

    if char.nil? || char == '0' || char == '1'
      mem << buffer
    else
      CHARS_MAP[char].split("").each do |replacement|
         _convert(chars, mem, buffer + replacement)
      end
    end
  end
end

puts PhoneConverter.convert('250').inspect
