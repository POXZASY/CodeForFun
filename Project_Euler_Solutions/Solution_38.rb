def isPandigital(n, nums)
	numarr = n.to_s.split('').sort
	return numarr == nums
end

def concatenate(n, m)
	numstrs = Array.new
	(1..m).each do |i|
		numstrs.push((n*i).to_s)
	end
	totalstr = ""
	numstrs.each do |s|
		totalstr+=s
	end
	return totalstr.to_i
end

def main
	nums = Array.new
	(1..9).each do |a|
		nums.push(a.to_s)
	end
	max = 0
	(1..9999).each do |n|
		(1..9).each do |i|
			val = concatenate(n, i)
			if isPandigital(val, nums) and val > max
				max = val
			end
		end
	end
	
	puts "Solution: " + max.to_s
end

main