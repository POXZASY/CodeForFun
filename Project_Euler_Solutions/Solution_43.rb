def main
	#generate all the pandigitals
	pandigitals = ["0"]
	#iterate through each digit to be added
	(1..9).each do |d|
		newpans = Array.new
		#iterate through each existing number, and add the new digit to each possible location
		pandigitals.each do |p|
			newdigit = d.to_s
			d.times do |i|
				newpans.push(p.clone.insert(i, newdigit))
			end
			newpans.push(p << newdigit)
		end
		pandigitals = newpans
	end
	#pandigitals.map!{|i| i.to_i}
	pandigitals.delete_if{|i| i.length < 10}
	#iterate through the pandigitals and check the conditions
	divisors = [2, 3, 5, 7, 11, 13, 17]
	sum = 0
	pandigitals.each do |p|
		(1..7).each do |i|
			numstr = String.new
			numstr << p[i]
			numstr << p[i+1] 
			numstr << p[i+2]
			val = numstr.to_i
			if val % divisors[i-1] != 0
				break
			end
			if i == 7
				sum += p.to_i
			end
		end
	end
	puts "Solution: " << sum.to_s
end 

main