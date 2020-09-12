def factorial(n)
	product = 1
	(1..n).each do |i|
		product = product * i
	end
	return product
end

def binomialCoeff(n, k)
	return factorial(n) / (factorial(k)*factorial(n-k))
end

def main
	count = 0
	(1..100).each do |n|
		(0..n).each do |k|
			if binomialCoeff(n, k) > 1000000
				count += 1
			end
		end
	end
	puts "Solution: " << count.to_s
end

main