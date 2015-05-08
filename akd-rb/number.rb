module PhoneConverter
  file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'dictionary.txt'))
  words = File.open(file).select { |w| w =~ /^\w+$/ }.map(&:chomp)

  def dictionary(array, index = 0)
    res = array.group_by{|i| i[index].downcase}
    dictionary = {}
    index = index + 1
    res.each do |key, value|
      dictionary[key] = value.group_by{|i| i[index].downcase}
    end
    dictionary
  end

  dic = dictionary(words)

  def convert(phone, result = [])
    result.tap do |mem|
      _convert(phone, mem)
    end
  end

  private

  def _convert(ch, mem, buffer = '')
    chars = {"2" => "ABC", "3" => "DEF", "4" => "GHI", "5" => "JKL", "6" => "MNO", "7" => "PQRS", "8" => "TUV", "9" => "WXYZ" }
    char = ch[buffer.size]

    if char.nil?
      mem << buffer
    else
      chars[char].split("").each do |replacement|
         _convert(ch, mem, buffer + replacement)
      end
    end
  end
end

puts PhoneConverter.convert('588')




def add_word(word, hash)
  new_place = word.chars.reduce(hash) {|acc, v| acc[v] ||= {}; acc[v]}
  new_place[:end] = word
  hash
end


def get_words(start, hash)
  place = start.chars.reduce(hash) {|acc, v| acc[v] if acc}
  place ? [place[:end]] + place.flat_map {|k, v| get_words("", v) unless k == :end} : []
end
