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

def arePermutations(n, m)
	return n.to_s.split('').sort == m.to_s.split('').sort
end

def main
	#generate all primes up to root 10000
	primes = [2]
	(3..Math.sqrt(10000).floor).step(2) do |i|
		if isPrime(i, primes)
			primes.push(i)
		end
	end
	#iterate over all possible starting numbers
	(1001..9997).step(2) do |i|
		if i == 1487 or i == 4817 or i == 8147
			next
		end
		if isPrime(i, primes)
			#iterate over all possible sequences
			(1..(((9999-i)/2).floor)).each do |a|
				j = i + a
				k = j + a
				if isPrime(j, primes) and isPrime(k, primes)
					if arePermutations(i, j) and arePermutations(j, k)
						puts "Solution: " + i.to_s + j.to_s + k.to_s
						return
					end
				end
			end
		end
	end
end

main