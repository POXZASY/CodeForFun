def isPrime(n, primes)
	if n < 2 
		return false
	end
	primes.each do |p|
		if p*p > n
			break
		end
		if n%p==0 
			return false
		end
	end
	return true
end

def isTruncPrime(n, primes)
	vals = Array.new
	numstr = n.to_s
	(1..numstr.length-1).each do |i|
		if !(isPrime(numstr[0..i-1].to_i, primes) and isPrime(numstr[i..numstr.length-1].to_i, primes))
			return false
		end
	end
	return true
end

def main
	truncprimes = Array.new
	primes = [2, 3, 5, 7]
	num = 11 #single digit prime numbers don't count
	while truncprimes.length < 11
		if isPrime(num, primes)
			primes.push(num)
			if isTruncPrime(num, primes)
				truncprimes.push(num)
			end
		end
		num+=2
	end	
	sum = 0
	truncprimes.each do |p|
		sum+=p
	end
	p truncprimes
	puts "Solution: " + sum.to_s
end

main