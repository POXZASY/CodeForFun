def isPrime(n, primes)
	primes.each do |p|
		if n%p == 0
			return false
		end
		if p*p > n
			break
		end
	end
	primes.push(n)
	return true
end

def fourPrimeDivisors(n, primes)
	count = 0
	primes.each do |p|
		if n%p == 0
			count += 1
		end
	end
	return count >= 4
end

def main
	n = 3
	primes = [2]
	while true
		if !isPrime(n, primes)
			if (n..n+3).all?{|i| fourPrimeDivisors(i, primes)}
				puts "Solution: " << n.to_s
				return
			end
		end
		n += 1
	end
end

main