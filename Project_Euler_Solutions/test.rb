def addCoins(purse)
	total = 8
	puts "----------------------------------"
	puts purse
	puts "Total:"+total.to_s
	if total == 10
		$count += 1
	elsif total < 10
		purse.each do |coin, vals|
			#if the coin still needs to be added
			if vals[1] == 0
				vals[1] = 1
				inc = 0
				while total+inc <= 10
					puts "Total:"+total.to_s	
				end
				break
			end
		end
	end
end

def main
	purse = {200=>[0, 0], 100=>[0, 0], 50=>[0, 0], 20=>[0, 0], 10=>[0, 0], 5=>[0, 0], 2=>[0, 0], 1=>[0, 0]}
	addCoins(purse)
	puts "Solution: "+$count.to_s
end

main