
#* Assignment: TTT Bonus Features (Improved Join)

# Improved "join"

# Currently, we're using the Array#join method, which can only insert a delimiter between the array elements, and isn't smart enough to display a joining word for the last element.

# Write a method called joinor that will produce the following result:

# ---------------------------------------------

=begin

* P - [Understanding the] Problem 

Inputs:
- Arr

Outputs:
- Str 

Explicit Requirements: 
- Method needs to produce output that includes "and" || "or" before the last element. 

Implicit Requirements:
- If there is no argument for the delimeter, "or" will be placed before the last element. 
- If the last argument is an empty space, "or" will be placed before the last element. 
- If the the last argument is 'and', i.e., 'and' will be placed before the last element.  

Clarifying Questions: 
- Will the value ever be anything other than "or" || "and"? 

# ---------------------------------------------

* E - Examples / Test Cases 

joinor([1, 2])                      # => "1 or 2"
joinor([1, 2, 3])                  # => "1, 2, or 3"
joinor([1, 2, 3], '; ')            # => "1; 2; or 3"
joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"

# ---------------------------------------------

* D - Data Structure 

=> Arr[]

[1, "or", 2] => "1 or 2"

# ---------------------------------------------

* A - Algorithm 

# Algorithm:
  - #* Helper method str_join: accepts 3 parameters (arr, delimeter, word)
    string = arr.insert(arr[-2], word).join(" ")
    new_arr = []
    counter = 1
    loop do 
      new_arr << counter
      string.insert(counter,delimeter)
      counter += 3
      break if new_arr.size == arr.size - 2
    end 
    string
    end 
  end 
  -#* Main method join_or: accepts 3 parameters (arr, delimeter, word)
    if arr.size == 2 && delimeter == "" && word == ""
      arr.insert(arr[-2], 'or').join(" ")
    elsif arr.size > 2 && delimeter == "" && word == ""
      str_join(arr, delimeter=",", word="or")
    elsif arr.size > 2 && delimeter && word == ""
      str_join(arr, delimeter=";", word="or")
    elsif arr.size > 2 && delimeter && word
      str_join(arr, delimeter=",", word="and")
    end 
  end 

=end 

# ---------------------------------------------

#* C - Code 

def str_join(arr, delimeter="", word="")
  string = arr.insert(arr[-2], word).join(" ")
    new_arr = []
    counter = 1 
    loop do 
      new_arr << counter
      string.insert(counter, delimeter)
      counter += 3
      break if new_arr.size == arr.size - 2
    end
  string
end 

def joinor(arr, delimeter="", word="")
  if arr.size == 1 && delimeter == "" && word == ""
    arr.join("")
  elsif arr.size == 2 && delimeter == "" && word == ""
    arr.insert(arr[-2], 'or').join(" ") 
  elsif arr.size > 2 && delimeter == "" && word == ""
    str_join(arr, delimeter=",", word="or")
  elsif arr.size > 2 && delimeter && word == ""
    str_join(arr, delimeter=";", word="or")
  elsif arr.size > 2 && delimeter && word
    str_join(arr, delimeter=",", word="and")
  end
end 

p joinor([2])                                                     # => "2"
p joinor([1, 2])                                                 # => "1 or 2"
p joinor([1, 2, 3])                                             # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')                                       # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')                             # => "1, 2, and 3"