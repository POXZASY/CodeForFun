require 'date'

count = 0

currentday = Date.new(1901, 1, 1)
while currentday.year < 2001
	if currentday.mday == 1 and currentday.wday == 6
		count+=1
	end
	currentday+=1
end

puts "Solution: " + count.to_s