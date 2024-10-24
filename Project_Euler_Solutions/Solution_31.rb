def purseTotal(purse, coins)
	total = 0
	coins.length.times do |i|
		total+=coins[i]*purse[i]
	end
	return total
end

def main
	coins = [200, 100, 50, 20, 10, 5, 2, 1]
	allpurses = Array.new
	allpurses.push([0,0,0,0,0,0,0,0])

	coinplace=0
	#iterate through each coin
	coins.each do |c|
		temppurses = []
		#iterate through each existing purse
		#add to temppurses all the possible variants with the new coin
		allpurses.each do |p|
			currentpurse = p.clone
			#while another coin can fit
			while purseTotal(currentpurse, coins) <= 200
				temppurses.push(currentpurse.clone)
				currentpurse[coinplace]+=1				
			end
		end
		allpurses = temppurses.clone
		coinplace+=1		
	end

	count = 0
	allpurses.each do |p|
		if purseTotal(p, coins)==200
			count+=1
		end
	end


	puts "Solution: "+count.to_s
end

main
