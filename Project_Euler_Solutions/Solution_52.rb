require "set"

#set of digits
def getDigits(n)
	digits = Set.new
	temp = n
	while temp > 0
		newdigit = temp%10
		digits.add(newdigit)
		temp = (temp - newdigit)/10
	end
	return digits
end

def main
	i = 1
	while true
		#compare 1 to 2
		digits1 = getDigits(i)
		digits2 = getDigits(2*i)		
		if digits1 == digits2
			#compare 2 to 3
			digits3 = getDigits(3*i)
			if digits2 == digits3
				#compare 3 to 4
				digits4 = getDigits(4*i)
				if digits3 == digits4
					#compare 4 to 5
					digits5 = getDigits(5*i)					
					if digits4 == digits5
						#compare 5 to 6
						digits6 = getDigits(6*i)
						if digits5 == digits6
							puts "Solution: " << i.to_s
							return
						end
					end
				end
			end
		end
		i += 1
	end
end

main