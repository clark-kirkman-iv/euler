# Solves Euler problem 1: https://projecteuler.net/problem=1
# Clark Kirkman IV
# clark.kirkman.iv@gmail.com
#
# Run: ruby 1.rb 1000

# returns a scaled, summed integer sequence of n terms
def sequence_sum(scale, n)
  return scale * n * (n+1)/2
end

raise "

Usage: #{File.basename(__FILE__)} <N>

Solves https://projecteuler.net/problem=1

Sums all multiples of 3 and 5 below N

" if ARGV.length != 1

cap = ARGV.shift.to_i

# Summing all multiples of X is the same as summing
# sequences of integers (where X == 1) and scaling by X:
# sum(1..n, stride=1) = 1 * n * (n+1) / 2
# sum(X..X*n, stride=X) = X * n * (n+1) / 2

# Sum multiples of 3, 5, and subtract out in-common
# (double counted) values (multiples of 3*5=15)

# determine all three sequence lengths
sequence_length = Hash[
                       [3,5,15].map{ |multiple|
                         [multiple, (cap.to_f / multiple).ceil - 1]
                       }
                      ]

# compute
total = sequence_sum(3, sequence_length[3]) +
        sequence_sum(5, sequence_length[5]) -
        sequence_sum(15, sequence_length[15])

# report
puts "Sum of multiples of 3 and 5 below #{cap} is: #{total}"
