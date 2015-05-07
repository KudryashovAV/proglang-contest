# dic_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'dictionary.txt'))
# code = { "2" => "ABC", "3" => "DEF", "4" => "GHI", "5" => "JKL", "6" => "MNO", "7" => "PQRS", "8" => "TUV", "9" => "WXYZ" }
# number = "0508812218"
# words = File.open(dic_file).select { |w| w =~ /^\w+$/ }.map(&:chomp)
# new_array_words = words.map{|x| x.scan(/[A-Za-z]+?/)}
# letters =('a'..'z').to_a
# a={}
# i=0
# k=0
# while i<=26 do
#   words.each do |w|
#     if w[k] == letters[i]
#       a[letters[i]] << w[k]
#     end
#   end
#   i = i+1
# end
file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'd.txt'))
words = File.open(file).select { |w| w =~ /^\w+$/ }.map(&:chomp)
dictionary = words.group_by{|i| i[0].downcase}

module PhoneConverter
  dic_file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'dictionary.txt'))
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
