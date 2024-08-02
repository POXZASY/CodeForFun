# How many n-digit positive integers exist which are also an nth power?
# The smallest n-digit number is 10^(n-1)
# The largest n-digit number is 10^n - 1
# For bases b < 10, there exists an N s.t. for all n > N, 10^(n-1) > b^n, i.e. all n-digit numbers are greater than b^n
# For bases b >= 10, every kth power has more than k digits

def num_digits(n)
	count = 0
	until n == 0
		n = (n - (n % 10)) / 10
		count += 1
	end
	count
end

def main
	count = 0
	(1..9).each do |b|
		n = 1
		loop do
			break if 10**(n-1) > b**n
			count += 1 if num_digits(b**n) == n
			n += 1
		end
	end
	puts count
end

main