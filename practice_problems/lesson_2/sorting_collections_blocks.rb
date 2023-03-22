# Practice Problems: Sorting, Nested Collections, and Working with Blocks

#____________________________

# Problem 1: How would you order this array of number strings by descending numeric value?

arr = ['10', '11', '9', '7', '8']

numeric_strings = arr.map { |string| string.to_i }.sort { |a, b| b <=> a }
numeric_strings.map { |number| number.to_s }
# => ["11", "10", "9", "8", "7"]

#____________________________

# Problem 2: How would you order this array of hashes based on the year of publication of each book, from the earliest to the latest?

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

books.sort_by { |book| book[:published] }
# => [{:title=>"War and Peace", :author=>"Leo Tolstoy", :published=>"1869"}, {:title=>"Ulysses", :author=>"James Joyce", :published=>"1922"}, {:title=>"The Great Gatsby", :author=>"F. Scott Fitzgerald", :published=>"1925"}, {:title=>"One Hundred Years of Solitude", :author=>"Gabriel Garcia Marquez", :published=>"1967"}]

#____________________________

# Problem 3: For each of these collection objects demonstrate how you would reference the letter 'g'.

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
arr1[2][1][3]
# => "g"

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
arr2[1][:third][0]
# => "g"

arr3 = [['abc'], ['def'], {third: ['ghi']}]
arr3[2][:third][0][0]
# => "g"

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
hsh1['b'][1]
# => "g"

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
hsh2[:third].key(0)
# => "g"

#____________________________

# Problem 4: For each of these collection objects where the value 3 occurs, demonstrate how you would change this to 4

arr1 = [1, [2, 3], 4]
arr1[1][1] = 4
arr1
# => [1, [2, 4], 4]

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4
arr2
# => [{:a=>1}, {:b=>2, :c=>[7, 6, 5], :d=>4}, 4]

hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2] = 4
hsh1
# => {:first=>[1, 2, 4]}

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4
hsh2
# => {["a"]=>{:a=>["1", :two, 4], :b=>4}, "b"=>5}

#____________________________

# Problem 5: Determine the total age of just the male members of the family.

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

sum = 0
munsters.each do |key, value|
  sum += value["age"] if value["gender"] == "male"
end
sum
# => 444

#____________________________

# Problem 6: Given this previously seen family hash, print out the name, age and gender of each family member:

# (Name) is a (age)-year-old (male or female).

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  puts "(#{key}) is a (#{value["age"]})-year-old #{value["gender"]}."
end
# => (Herman) is a (32)-year-old male.
# => (Lily) is a (30)-year-old female.
# => (Grandpa) is a (402)-year-old male.
# => (Eddie) is a (10)-year-old male.
# => (Marilyn) is a (23)-year-old female.

#____________________________

# Problem 7: Given this code, what would be the final values of a and b? Try to work this out without running the code.

a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a
arr
# => [4, [3, 8]]

#____________________________


# Problem 8: Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

VOWELS = %w(a e i o u)

hsh.each do |key, value|
  value.each do |words|
    words.chars.each do |char|
      puts char if VOWELS.include?(char)
    end
  end
end

#____________________________

# Problem 9: Given this data structure, return a new array of the same structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

arr.map do |subarray|
  subarray.sort do |a, b|
    b <=> a
  end
end
# => [["c", "b", "a"], [3, 2, 1], ["green", "blue", "black"]]

#____________________________

# Problem 10: Given the following data structure and without modifying the original array, use the `map` method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.

[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hash|
  hash.transform_values { |value| value + 1 }
end
# => [{:a=>2}, {:b=>3, :c=>4}, {:d=>5, :e=>6, :f=>7}]

#____________________________

# Problem 11: Given the following data structure use a combination of methods, including either the select or reject method, to return a new array identical in structure to the original but containing only the integers that are multiples of 3.

arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

# [[], [3, 12], [9], [15]]

arr.map do |subarray|
  subarray.select do |number|
    number if number % 3 == 0
  end
end
# => [[], [3, 12], [9], [15]]