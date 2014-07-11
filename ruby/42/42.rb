# Solves Euler problem 42: https://projecteuler.net/problem=42
# Clark Kirkman IV
# clark.kirkman.iv@gmail.com
#
# Run: ruby 42.rb words.txt

# A Hash of char (a-z) -> value (1-26)
CHAR_VALUE = Hash[('a'..'z').to_a.map{ |char|
                    [char, char.ord - 'a'.ord + 1]
                  }
                 ]
MAX_CHAR_VALUE = CHAR_VALUE.values.max

# returns an Array containing true at triangle number indicies.
def generate_triangle_numbers(n)
  is_triangle = Array.new(n+1, false)
  
  index = 1
  increment = 1
  while index < is_triangle.length
    is_triangle[index] = true
    increment += 1
    index += increment
  end
  
  return is_triangle
end

# converts a String to an integer by converting each character to
# a representative value and summing.
def word_value(word)
  lower_case = word.downcase
  raise "Invalid word: #{word}" if lower_case =~ /[^a-z]+/
  return lower_case.split("").map{ |char| CHAR_VALUE[char] }.inject(0, :+)
end

raise "

Usage: #{File.basename(__FILE__)} <word text file>

Solves https://projecteuler.net/problem=42

" if ARGV.length != 1

word_file = ARGV.shift

# read and prep input words for testing.  Char case is handled by word_value().
words = IO.read(word_file).split(",").map{ |word| word.strip.gsub("\"","") }
longest_word_length = words.map{ |word| word.length }.sort.last

# predetermine triangle numbers as far out as potentially needed
is_triangle = generate_triangle_numbers(longest_word_length * MAX_CHAR_VALUE)

# check each word for triangleness
word_is_triangle = Array.new(words.length)
words.each_with_index{ |word, index|
  word_is_triangle[index] = is_triangle[word_value(word)]
}

# report
n_triangle_words = word_is_triangle.select{ |is_triangle| is_triangle }.length
puts "#{n_triangle_words} of #{words.length} words are triangle."
