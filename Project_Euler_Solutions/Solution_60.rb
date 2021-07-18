require "set"

#lowest sum of a set of 5 primes for which any two primes concatenate to product another prime
#solution: 13 5197 5701 6733 8389, sum 26033

$primes = Set.new

def isPrime(n)
	$primes.each do |p|
		return false if n%p == 0
		break if p > Math.sqrt(n)
	end
	return true
end

def numDigits(n)
	digits = 0
	while n > 0
		n = (n - (n%10))/10
		digits += 1
	end
	return digits
end

def concatsPrime(p, q)
	digits_p = numDigits(p)
	digits_q = numDigits(q)
	#check pq prime	
	p_new = p * (10**digits_q)
	return false if !isPrime(p_new + q)
	#check qp prime
	q_new = q * (10**digits_p)
	return false if !isPrime(q_new + p)
	return true
end

def main
	program_start = Time.now
	sumBound = 30_000
	primesBound = Math.sqrt(sumBound * (10 ** (numDigits(sumBound))) + sumBound).to_i #based on largest prime needed to verify concat number. guarenteed > sumBound
	#initialize the list of primes
	$primes.add(2)
	(3..primesBound).step(2).each do |i|
		$primes.add(i) if isPrime(i)
	end
	#iterating over the bound of the sum, by powers of 10
	solution = -1
	while solution < 0
		$primes.each do |p|
			#puts p
			next if p == 2
			next if p == 5
			break if sumBound - 5*p < 0
			$primes.each do |q|
				next if q == 5
				next if q < p
				break if sumBound - p - 4*q < 0
				next if !concatsPrime(p, q)
				$primes.each do |r|
					next if r < q
					break if sumBound - p - q - 3*r < 0
					next if !concatsPrime(p, r)
					next if !concatsPrime(q, r)
					$primes.each do |s|
						next if s < r
						break if sumBound - p - q - r - 2*s < 0
						next if !concatsPrime(p, s)
						next if !concatsPrime(q, s)
						next if !concatsPrime(r, s)
						$primes.each do |t|
							next if t < s
							break if sumBound - p - q - r - s - t < 0
							next if !concatsPrime(p, t)
							next if !concatsPrime(q, t)
							next if !concatsPrime(r, t)
							next if !concatsPrime(s, t)
							sum = p + q + r + s + t
							#puts "Sum: " << sum.to_s
							solution = sum if solution < 0
							solution = sum if sum < solution
							sumBound = solution
						end
					end
				end
			end
		end
		
		break if solution > 0
		
		#update the current list of primes
		$primes.clear
		sumBound = sumBound * 10
		primesBound = Math.sqrt(sumBound * (10 ** (numDigits(sumBound))) + sumBound).to_i
		$primes.add(2)
		(3..primesBound).step(2).each do |i|
			$primes.add(i) if isPrime(i)
		end
	end
	puts "Solution: " << solution.to_s
	program_end = Time.now
	puts "Time for program to run: " << (program_end - program_start).to_s << " seconds"
end

main