def isPandigit(a, b, c)
	pandigit = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
	achars = a.to_s.split('')
	bchars = b.to_s.split('')
	cchars = c.to_s.split('')
	charlist = (achars+bchars+cchars).sort
	return pandigit == charlist	
end

def main
	products = Array.new

	#only 4 digit numbers will work as products
	#check each by dividing by all the 1 and 2-digit numbers
	#if an identity occurs, add it to the array


	(1000..9999).each do |i|
		(1..99).each do |j|
			multiplier = i.to_f / j
			if(multiplier%1==0 and isPandigit(j, multiplier.to_i, i))
				#puts j.to_s + " " + multiplier.to_i.to_s + " " + i.to_s
				products.push(i)
				break
			end
		end
	end
	total = 0
	products.each {|i| total+=i}
	puts "Solution: "+total.to_s
end

main