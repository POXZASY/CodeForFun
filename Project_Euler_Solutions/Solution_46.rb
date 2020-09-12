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

def isSquare(n)
	return Math.sqrt(n)%1 == 0
end

def main
	n = 35
	primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31]
	while true
		#prime
		if isPrime(n, primes)
			primes.push(n)
		#odd composite
		else
			#check each prime, to see if difference is twice a square
			foundsolution = primes.all? do |p|
				!isSquare((n-p)/2)
			end
			if foundsolution
				puts "Solution: " << n.to_s
				return
			end
		end
		n += 2
	end
end

main