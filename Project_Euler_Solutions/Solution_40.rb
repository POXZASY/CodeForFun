#brute force approach
def main
	product = 1
	num = Array.new
	count = 1
	while num.length <= 1000000
		num.concat(count.to_s.split('').map{|i| i.to_i})
		count += 1
	end
	vals = [1, 10, 100, 1000, 10000, 100000, 1000000]
	vals.each do |v|
		product = product * num[v-1]
	end
	puts "Solution: " + product.to_s
end

main