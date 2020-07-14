def main
	max = 0
	pvalue = 0
	#count the pairs for each p from 1 to 1000
	(1..1000).each do |p|
		pcount = 0
		(1..p).each do |a|
			(a..p).each do |b|
				if p*p-2*p*a-2*p*b+2*a*b == 0
					pcount+=1
				end
			end
		end
		if pcount > max
			max = pcount
			pvalue = p
		end
	end
	
	puts "Solution: " + pvalue.to_s
end

main