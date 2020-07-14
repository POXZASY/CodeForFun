#this works but doesn't address the problem LOL
def getOrderings(arr)
	if arr.length == 1
		orderings = [arr]
		return orderings
	end
	orderings = Array.new #array of arrays
	arr.length.times do |i|
		temparr = arr.clone
		temparr.delete_at(i)
		subarrs = getOrderings(temparr)
		subarrs.each do |s|
			orderings.push([arr[i]] + s)
		end
	end
	return orderings
end

def getRotations(arr)
	rotations = Array.new #array of arrays
	#one iteration for each rotation
	arr.length.times do |i|
		r = Array.new
		#assign values to the new array
		arr.length.times do |j|
			r[j]=arr[(j+i)%arr.length]
		end		
		rotations.push(r)
	end
	return rotations
end

#takes list of primes
def isCircular(n, primes)
	#get all the digit variants
	digits = n.to_s.split('')
	orderings = getRotations(digits)
	orderings.each do |o|
		numstr = ""
		o.each do |c|
			numstr+=c
		end
		if !(primes.include? numstr.to_i)
			return false
		end
	end
	puts n
	return true
end

def main
	#get all the primes
	primes = [2]
	(3..999999).step(2) do |i|
		#check for primality
		primes.each do |p|
			#if the number is not a prime, go to the next number
			if i%p == 0			
				break
			#if the number is prime, check for circularity
			elsif p > Math.sqrt(i)
				primes.push(i)
				break
			end
		end
	end	
	#check whether each prime is circular
	count = 0
	primes.each do |p|
		if isCircular(p, primes)
			count+=1
		end
	end
	
	puts "Solution: "+count.to_s
end

main