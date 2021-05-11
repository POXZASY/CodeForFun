def reverseDigits(n)
	#retrieve each of the digits (retrieves in desired order!)
	digits = Array.new
	while n > 0
		digit = n % 10
		digits.push(digit)
		n = (n - digit)/10
	end
	#add back the digits
	retVal = 0
	numdigits = digits.length
	numdigits.times do |i|
		retVal += digits[i] * 10**(numdigits - 1 - i)
	end
	retVal
end
def isLychrel(n)
	49.times do
		n = n + reverseDigits(n)
		return false if n == reverseDigits(n)
	end
	true
end
def main
	count = 0
	(1...10000).each do |i|
		count += 1 if isLychrel(i)
	end
	puts "Solution: " << count.to_s
end
main