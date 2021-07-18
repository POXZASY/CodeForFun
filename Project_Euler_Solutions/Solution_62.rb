require 'set'

#find the smallest cube such that five permutations of its digits are cube

#perms holds all the permutations
#remaining holds the array without the processed elements
#processed holds the array without the remaining elements
def permutations(perms, digits)
	counts = Array.new(digits.size, 0)
	
end

def getNumber(arr)
	multiplier = 1
	num = 0
	(0...arr.size).each do |i|
		num += arr[arr.size-1-i]*multiplier
		multiplier *= 10
	end
	num
end

def main	
	#iterate over the cubes
	n = 1
	
	checkedcubes = Set.new
	
	while true
		puts n
		
		if checkedcubes.include? n
			n += 1
			next
		end
		
		#get all the permutations of the digits
		digits = []
		k = n**3
		while k > 0
			digits.push(k%10)
			k /= 10
		end
		digits.reverse!
		
		perms = []
		permutations(perms, digits)
		
		permnums = Set.new
		perms.each do |p|
			permnums.add(getNumber(p))
		end
		cubecount = 0
		#iterate over the permutations and count the number of cubes
		permnums.each do |p|
			possiblecube = Math.cbrt(p)
			if possiblecube%1 == 0
				checkedcubes.add(possiblecube.to_i)
				cubecount += 1
			end
		end
		
		if cubecount >= 3
			puts "Solution: " << (n**3).to_s
			return
		end
		
		n += 1
	end
end

time1 = Time.now
main
time2 = Time.now
puts "Time for program to run: " << (time2 - time1).to_s << " seconds"