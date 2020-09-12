require 'set'

def isPrime(n, primes)
	primes.each do |p|
		if n%p == 0
			return false
		end
		if p*p > n
			break
		end
	end
	return true
end

def main
	#generate list of all the primes
	primesset = Set.new [2]
	(3..999999).step(2).each do |i|
		if isPrime(i, primesset)
			primesset.add(i)
		end
	end
	consecprime = 2
	conseclength = 1
	primes = primesset.to_a
	#iterate over all the bases of the sums
	primes.length.times do |b|
		currentsum = 0
		c = 0 #number of consecutives
		while b + c < primes.length and currentsum < 1000000
			currentsum += primes[b+c]
			c += 1
			if primesset.include?(currentsum) and c > conseclength
				consecprime = currentsum
				conseclength = c
			end
		end		
	end
	puts "Solution: " << consecprime.to_s
end

main