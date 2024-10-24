

def main
	rationals = Array.new
	(10..99).each do |d|
		(10..d-1).each do |n|
			#make sure fraction isn't trivial
			if(n%10!=0 or d%10!=0)
				numdigits = n.to_s.split('').map{|i| i.to_i} #numerator digits
				denomdigits = d.to_s.split('').map{|i| i.to_i} #denominator digits
				#check if either of the digits in the numerator are also in the denominator
				numdigits.each do |i|
					if denomdigits.include? i
						numdigits.delete_at(numdigits.index(i))
						denomdigits.delete_at(denomdigits.index(i))
						if numdigits[0].to_f / denomdigits[0] == n.to_f / d
							rationals.push(Rational(n, d))
						end
						break
					end
				end
			end
		end
	end
	base = Rational(1)
	rationals.each do |r|
		base = base * r
	end
	puts base
end
main
