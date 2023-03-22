# Practice Problems: Additional Practice

#____________________________

# 1. Given the array below:

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Turn this array into a hash where the names are the keys and the values are the positions in the array.

hsh = {}
flintstones.each_with_index do |name, index|
  hsh[name] = index
end
hsh
# => {"Fred"=>0, "Barney"=>1, "Wilma"=>2, "Betty"=>3, "Pebbles"=>4, "BamBam"=>5}

#____________________________

# 2. Add up all of the ages from the Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

ages.values.sum
# => 6174

#____________________________

# 3. In the ages Hash: Remove people with age 100 and greater.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

filtered_ages = ages.select { |key, value| value <= 100 }
filtered_ages
# => {"Herman"=>32, "Lily"=>30, "Eddie"=>10}

#____________________________

# 4. Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

arr = []
min_ages = ages.each_value { |value| arr << value }
arr.min
# => 10

#____________________________

# 5. In the array: Find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.each_with_index do |name, index|
  # puts index if name.start_with?("Be") # 3
end

#____________________________

# 6. Write code that changes the array below so that all of the names are shortened to just the first three characters. Do not create a new array.

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! do |name|
  name[0, 3]
end

flintstones
# => ["Fre", "Bar", "Wil", "Bet", "Bam", "Peb"]

#____________________________

# 7. Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

hsh = {}
statement.split.join.chars.each do |letter|
  hsh[letter] = statement.count letter
end
hsh
# => {"T"=>1, "h"=>1, "e"=>2, "F"=>1, "l"=>1, "i"=>1, "n"=>2, "t"=>2, "s"=>2, "o"=>2, "R"=>1, "c"=>1, "k"=>1}

#____________________________

# What happens when we modify an array while we are iterating over it? What would be output by this code?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# numbers.each_with_index do |number, index|
#   p "#{index}  #{numbers.inspect}  #{number}"
#   numbers.shift(1)
# end

=begin

"0  [1, 2, 3, 4]  1"     index 0 --> 1
"1  [2, 3, 4]     3"     index 1 --> 3

=> [3, 4]

From this we see that our array is being changed as we go (shortened and shifted), and the loop counter used by #each is compared against the current length of the array rather than its original length.

=end

#____________________________

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

=begin

"0  [1, 2, 3, 4]   4"      index 0 --> 1
"1  [1, 2, 3]       3"      index 1 --> 2

=> [2, 3]

=end

#____________________________

# Write your own version of the rails `titleize` implementation.

words = "the flintstones rock"

def titleize(string)
  words = string.split(' ').map do |word|
    word.capitalize
  end
  words.join(' ')
end

p titleize(words)

#____________________________

# Given the munsters hash below: Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below.

# Note: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.

# Try using a case statement along with Ruby Range objects in your solution:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  case value["age"]
  when 0..17
    value["age_group"] = 'kid'
  when 18..64
    value["age_group"] = 'adult'
  else
    value["age_group"] = 'senior'
  end
end

