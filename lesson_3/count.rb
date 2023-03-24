
require "pry" # add this to use Pry

counter = 0

loop do 
  counter += 1
  binding.pry # execution will stop here 
  break if counter == 5
end 

# pry is similar to the JavaScript debugger. 

#* Debugging is arguably the most important skill you need to learn as a programmer. 

# Focus on developing a patient, systematic temperament; carefully read error messages; 

# Use all the wonderful resources at your disposal; approach debugging in sequential steps;

# Use the techniques we covered above -- especially Pry. 