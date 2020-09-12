def main
	#iterate through each pentagonal number, and compare it with all the previous
	#record the smallest pair where sum and diff are pentagonal
	#stop when difference between consequtive pentagonal numbers is greater than the current min diff
	pentagonals = []
	n = 1
	mindist = 99999999999999
	pj = -1
	pk = -1
	
	while true
		#add pentagonals 2n and 2n-1 (for addition check)
		newpenta2 = (2 * n) * (3 * (2 * n) - 1) / 2
		newpenta1 = (2 * n - 1) * (3 * (2 * n - 1) - 1) / 2
		pentagonals.push(newpenta1)
		pentagonals.push(newpenta2)
		#p pentagonals
		#iterate through each pentagonal up to index n
		penta = pentagonals[n-1] #get the nth pentagonal
		(0..n-2).each do |i| #iterate through pentagonals 1 to n-1
			#check sum and difference are pentagonal
			if pentagonals.include? penta + pentagonals[i] and pentagonals.include? penta - pentagonals[i]
				diff = penta - pentagonals[i]
				if diff < mindist
					pj = pentagonals[i]
					pk = penta
					mindist = diff
					puts "pj: " + pj.to_s + " pk: " + pk.to_s + " mindist: " + mindist.to_s
				end
			end
		end
		#check if difference between subsequent pentagonals is larger than the current min dist
		#puts pentagonals[n] - penta
		if pentagonals[n] - penta > mindist
			break
		end		
		n += 1
	end
	puts "Solution: " << mindist.to_s
end

main