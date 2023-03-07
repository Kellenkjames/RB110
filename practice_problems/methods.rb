# Practice Problems: Methods and More Methods

#____________________________

[1, 2, 3].select do |num|
  num > 5
  'hi'
end

=begin

* What is the return value of the `select` method below? Why?

=> New Array: [1, 2, 3]

`select` performs selection based on the truthiness of the block's return value. In this case, the return value will always be `'hi'`, which is a "truthy" value.

Therefore `select` will return a new array containing all of the elements in the original array.

=end

#____________________________

['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

=begin

* How does count treat the block's return value? How can we find out?

`count` considers the truthiness of the block's return value. In this case, the first 2 elements in the array evaluate as true. Therefore, the method will return the Integer 2.

=end

#____________________________

[1, 2, 3].reject do |num|
  puts num
end

=begin

* What is the return value of reject in the following code? Why?

=> New Array: [1, 2, 3]

The `reject` method evaluates the block's return value and returns a new Array containing items where the block's return value is "falsy". In this case, the `puts` method invocation always returns `nil`; therefore the block's return value is `nil`.

The return value of `reject` in the following code is a new Array containing the same Integers as the original object.

=end

#____________________________

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

=begin

* What is the return value of each_with_object in the following code? Why?

=> { "a" => '"ant", "b" => "bear", "c" => '"cat" }

The `each_with_object` accepts an empty Hash literal as an argument - this means the return object will be a Hash.

The block parameter `hash` uses index assignment to set the first char of each String as the key; while setting the full String as the value for each element in the Array.

Therefore, the method returns a new Hash object: { "a" => '"ant", "b" => "bear", "c" => '"cat" }

=end

#____________________________

hash = { a: 'ant', b: 'bear' }
hash.shift

=begin

* What does shift do in the following code? How can we find out?

shift removes the first hash entry; returns a 2-element Array containing the removed key and value:

=> [:a, "ant"]

=end

#____________________________

['ant', 'bear', 'caterpillar'].pop.size

=begin

* What is the return value of the following statement? Why?

=> 11

The `pop` method returns the last element of an array. In this case, we return the String 'caterpillar' and then invoke the `size` method on the returned String.

This would be the same as invoking`caterpillar`.size which returns 11.

=end

#____________________________

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

=begin

* What is the block's return value in the following code? How is it determined? Also, what is the return value of any? in this code and what does it output?

=> true

The block's return value is determined by truthiness. On line 109, the `odd?` method is evaluated for truthiness on each element in the collection.

Since at least one element in the collection meets the criterion of the `odd?` method - the method returns true.

* any? stops iterating after the first return value of the block evaluates as true - there is no need to evaluate the remaining items in the array; therefore, puts num is only ever invoked for the first item in the array: 1.

=end

#____________________________

arr = [1, 2, 3, 4, 5]
arr.take(2)

=begin

* How does take work? Is it destructive? How can we find out?

take: for non-negative integers 'n', returns the first n elements

=> [1, 2]

`Array#take` is a non-destructive method - it selects a specified number of elements from an array.

=end

#____________________________

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

=begin

# What is the return value of `map` in the following code? Why?

# => [nil, 'bear']

`map` always performs transformation on elements based on the block's return value. In this case, the method is checking if any value in the Hash has a size greater than 3.

When called on a Hash, `map` returns an array of objects returned by the block. Since the first value doesn't meet the criterion of the expression; it returns `nil`; the second value returns the String `bear`. 

* When none of the conditions in an if statement evalutes as true, the if statement itself returns nil. 

=end