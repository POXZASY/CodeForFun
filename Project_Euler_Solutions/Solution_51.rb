require "set"

#converts array of digits to number
def numFromDigits(arr)
	num = 0
	arr.length.times do |i|
		num += arr[i]*(10**(arr.length-1-i))
	end
	return num
end

#converts number to array of digits
def getDigits(n)
	digits = Array.new
	remaining = n
	while remaining > 0
		newdigit = remaining%10
		digits.push(newdigit)
		remaining = (remaining - newdigit)/10
	end
	return digits
end


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

#generate a family of values with the given digit replacement
def genFamily(p, arr)
	family = Set.new
	digits = getDigits(p)
	(0..9).each do |i|
		newdigits = digits
		arr.each do |j|
			newdigits[j] = i
		end
		if newdigits[0] != 0
			family.add(numFromDigits(newdigits))
		end
	end
	return family
end

def main
	primes = Set[2, 3, 5, 7]
	#iterate over the total number of digits in the number
	digits = 2
	orientations = [[]]
	while true
		#add primes to set with the new # of digits
		#also create a set of just the primes with that number of digits to iterate through
		digitprimes = Set.new
		lower = 10**(digits - 1)
		upper = 10**digits - 1
		(lower..upper).each do |i|
			if isPrime(i, primes)
				primes.add(i)
				digitprimes.add(i)
			end
		end
		#construct all the possible replacement orientations as arrays
		neworients = Array.new
		orientations.each do |o|
			neworients.push(o.clone.push(digits-2))
		end
		orientations.concat(neworients)
		digitprimes.each do |p|
			orientations.each do |o|
				if o.length == 0
					next
				end
				family = genFamily(p, o)
				primecount = 0
				family.each do |n|
					if primes.include? n
						primecount += 1
					end
				end
				if primecount >= 8
					puts "Solution: " << family.min.to_s
					return
				end
			end
		end
		digits += 1
	end
end

main