def wordVal(w)
	total = 0
	w.split('').each do |c|
		total += c.ord-64
	end
	return total
end

def main
	#generate some triangle numbers
	#words prob < 20 chars, so 20*26 should be sufficent upper bound
	#trinum of n=32 > 20*26
	trinums = Array.new
	(1..32).each do |n|
		trinums.push(0.5*n*(n+1))
	end
	wordfile = File.open("Problem_42.txt")
	words = wordfile.read.split(",").map{|s| s=s.delete('"')}
	wordfile.close
	count = 0
	words.each do |w|
		if trinums.include? wordVal(w)
			count += 1
		end
	end	
	puts "Solution: " + count.to_s
end

main