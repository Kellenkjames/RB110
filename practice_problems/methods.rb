# Practice Problems: Methods and More Methods

#____________________________

[1, 2, 3].select do |num|
  num > 5
  'hi'
end

=begin

* What is the return value of the `select` method below? Why?

`select` performs selection based on the truthiness of the block's return value. In this case, the block's return value; the String`'hi'`, is always a "truthy" value.

Therefore `select` will return a new array containing all of the elements in the original array.

=> [1, 2, 3]

=end

#____________________________

['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

=begin

* How does count treat the block's return value? How can we find out?

`count` considers the truthiness of the block's return value. In this case, the first two elements in the array; 'string' and 'bat', evaluate as true. Therefore, the method will return the Integer 2.

=> 2

=end

#____________________________

[1, 2, 3].reject do |num|
  puts num
end

=begin

* What is the return value of reject in the following code? Why?

The `reject` method evaluates the block's return value and returns a new Array containing items where the block's return value is "falsy".

In this case, the `puts` method invocation always returns `nil`; therefore the block's return value for each iteration is `nil`.

The return value of `reject` in the following code is a new Array containing the same Integers as the original object.

=> [1, 2, 3]

=end

#____________________________

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

=begin

* What is the return value of each_with_object in the following code? Why?

The `each_with_object` accepts an empty Hash literal as an argument - this means the return object will be a Hash.

The block parameter `hash` uses index assignment to set the first character of each String as the key; while setting the entire String as the value for each element in the Array.

Therefore, the method returns a new Hash object:

=> { "a" => '"ant", "b" => "bear", "c" => '"cat" }

=end

#____________________________

hash = { a: 'ant', b: 'bear' }
hash.shift

=begin

* What does shift do in the following code? How can we find out?

shift removes the first hash entry and returns a 2-element Array containing the removed key/value pair:

=> [:a, "ant"]

=end

#____________________________

['ant', 'bear', 'caterpillar'].pop.size

=begin

* What is the return value of the following statement? Why?

The `pop` method returns the last element of an array. In this case, `pop` is called on the Array object and returns the String 'caterpillar'; then`size` method is called on the returned String - this is an example of method chaining.

This would be the same as invoking`caterpillar`.size which returns the Integer 11.

=> 11

=end

#____________________________

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

=begin

* What is the block's return value in the following code? How is it determined? Also, what is the return value of any? in this code and what does it output?

=> true

The block's return value is determined by truthiness. On line 109, the `odd?` method is called on each `num` in the collection.

Since at least one element in the collection meets the criterion of the block's return value method - the method returns true.

any? stops iterating after the first return value of the block evaluates as true - there is no need to evaluate the remaining items in the array; therefore, `puts num` is only ever invoked for the first item in the array: 1.

=end

#____________________________

arr = [1, 2, 3, 4, 5]
arr.take(2)

=begin

* How does take work? Is it destructive? How can we find out?

take: for non-negative integers 'n', returns the first n elements

`Array#take` is a non-destructive method - it selects a specified number of elements from an array.

=> [1, 2]

=end

#____________________________

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

=begin

* What is the return value of `map` in the following code? Why?

`map` always performs transformation on elements based on the block's return value. In this case, the method is checking if any value in the Hash has a size greater than 3.

When called on a Hash, `map` returns an array of objects based on the block's return value.

Since the first value doesn't meet the criterion of the expression; it returns `nil`; the second value returns the String `bear`.

* When none of the conditions in an if statement evalutes as true, the if statement itself returns nil.

# => [nil, 'bear']

=end

#____________________________

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

=begin

* What is the return value of the following code? Why?

We can determine the block's return value by looking at the return value of the last element. In this case it's a bit tricky because of the `if` statement. 

For the first element, the `if` condition evaluates as false, which means `num` is the block's return value for that iteration.

For the rest of the elements in the array, `num > 1` evaluates as true, which means `puts num` is the last statement evaluated, which in turn, means that the block's return value is `nil` for those iterations.

=> [1, nil, nil]

=end