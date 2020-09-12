def main
	sum = 0
	(1..1000).each do |i|
		sum += (i**i)
		sum = sum%10000000000
	end
	puts "Solution: " << sum.to_s
end

main