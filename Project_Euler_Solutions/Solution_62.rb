def num_digits(n)
    total = 0
    while n > 0
        n = (n - (n % 10)) / 10
        total += 1
    end
    total
end


def isPermutation?(a, b)
	digit_counts = Array.new(10, 0)
	while a > 0
		digit = a % 10
		digit_counts[digit] += 1
		a = (a - digit) / 10
	end
	while b > 0
		digit = b % 10
		digit_counts[digit] -= 1
		b = (b - digit) / 10
	end

	digit_counts.all?{|c| c == 0}
end


def main
    n = 1
	# iterate over the number of digits
	loop do
		cubes = [n**3]
		# get all the cubes of that many digits
		while num_digits((n+1)**3) == num_digits(n**3)
			cubes.push (n+1)**3
			n += 1
		end
		# for each cube, compare it with all the cubes greater than it
		# continue until there is a set of 5 cubes satisfying this property
		(0...cubes.size).each do |i|
			(i+1...cubes.size).each do |j|
				next if !isPermutation? cubes[i], cubes[j]
				(j+1...cubes.size).each do |k|
					next if !isPermutation? cubes[j], cubes[k]
					(k+1...cubes.size).each do |x|
						next if !isPermutation? cubes[k], cubes[x]
						(x+1...cubes.size).each do |y|
							if isPermutation? cubes[x], cubes[y]
								puts "Solution: " << cubes[i].to_s
								return
							end
						end
					end
				end
			end
		end
		
		n += 1
	end
end


main
