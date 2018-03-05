# Task 1 solution
def check_the_bucket(bucket)
  bucket.include?("gold")
end

puts "Task 1:\n*************************************"
bucket1 = ["stone", "stone", "stone", "stone", "stone"]
bucket2 = ["gold", "stone", "stone", "stone", "stone"]
puts check_the_bucket(bucket1)
puts check_the_bucket(bucket2)


# Task 2 solution
def fizz_buzz(bottom, top)
  lookup = { 3 => "Fizz", 5 => "Buzz", 15 => "FizzBuzz" }

  (bottom..top).each do |number|
    value = [15, 5, 3].each do |divisor|
      break lookup[divisor] if (0..top).step(divisor).include?(number)
    end
    # value is either String or Array
    puts (value.class == String ? value : number)
  end
end

puts "\nTask 2:\n*************************************"
fizz_buzz(1, 100)