sum = 0
(1..999999).each do |i|
	numstr = i.to_s
	if numstr == numstr.reverse
		binary = i.to_s(2)
		if binary == binary.reverse
			sum+=i
		end
	end
end
puts "Solution: "+sum.to_s