file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'dictionary.txt'))
words = File.open(file).select { |w| w =~ /^\w+$/ }.map(&:chomp)
d = words.group_by{|i| i[0].downcase}


dictionary = words.group_by{|i| i[index].downcase}
letters =('a'..'z').to_a
for i in letters
  res[i] = res[i].group_by{|i| i[index+1].downcase} unless res[i].nil?
end

module PhoneConverter
  dic_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'dictionary.txt'))
  WORDS = File.open(file).select { |w| w =~ /^\w+$/ }.map(&:chomp)
  CHARS_MAP = {"2" => "ABC", "3" => "DEF", "4" => "GHI", "5" => "JKL", "6" => "MNO", "7" => "PQRS", "8" => "TUV", "9" => "WXYZ" }

  def dictionary(array, index = 0)
    res = array.group_by{|i| i[index].downcase}
    letters =('a'..'z').to_a
    dictionary(res[letters[index]], (index + 1))
  end

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
