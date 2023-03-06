# Practice Problems: Methods and More Methods

#____________________________

[1, 2, 3].select do |num|
  num > 5
  'hi'
end

=begin

* What is the return value of the `select` method below? Why?

=> [1, 2, 3]

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

