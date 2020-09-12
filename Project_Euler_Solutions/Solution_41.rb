def isPrime(n, primes)
	primes.each do |p|
		if n%p==0
			return false
		end
		if p*p >= n
			break
		end
	end
	return true
end

def main
	max = 0
	#generate list of primes up to sqrt of 1 bil
	primes = [2]
	(3..31623).each do |i|
		if isPrime(i, primes)
			primes.push(i)
		end
	end
	#generate all the pandigital numbers, and check each for primality
	pandigitals = [1]
	#iterate over num digits
	(2..9).each do |i|
		newpans = []
		istr = i.to_s
		#insert the new digit at every position of the pandigits
		pandigitals.each do |pan|
			panstr = pan.to_s
			panstr.length.times do |j|
				newpans.push(panstr.clone.insert(j, istr).to_i)
			end
			newpans.push((panstr.clone << istr).to_i)
		end
		pandigitals = newpans
		#check newpans for primality
		pandigitals.each do |pan|
			if isPrime(pan, primes) and pan > max
				max = pan
			end
		end
	end
	puts "Solution: " + max.to_s
end

main