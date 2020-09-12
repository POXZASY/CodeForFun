def isPentagonal(n)
	return Math.sqrt(24*n+1)%6 == 5
end

def isHexagonal(n)
	return Math.sqrt(8*n+1)%4 == 3
end

def main
	n = 286
	while true
		#get triangle number
		trinum = n * (n + 1) / 2
		#check if it is pentagonal
		if isPentagonal(trinum) and isHexagonal(trinum)
			puts "Solution: " << trinum.to_s
			break
		end
		n += 1
	end
end

main