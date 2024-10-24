#globals
$rows = Array.new
$maxsum = 0

#function to update the maximum found sum
#rows and columns are 0-indexed
def updateMax(currentsum, row, col)
	#check bounds
	if row>=$rows.length or col>row
		return
	end
	#update current sum
	currentsum = currentsum + $rows[row][col]
	if currentsum > $maxsum
		$maxsum = currentsum
	end
	#check if future nodes are promising
	if currentsum + (99*($rows.length-(row+1))) >= $maxsum
		#traverse tree
		updateMax(currentsum, row+1, col)
		updateMax(currentsum, row+1, col+1)
	end

end

def main
	#get the rows of the pyramid
	file = File.open("Problem_18.txt")
	rowstrs = file.readlines
	rowstrs.each do |r|
		$rows.push(r.split.map(&:to_i))
	end
	file.close
	updateMax(0, 0, 0)
	puts("Solution: "+$maxsum.to_s)
end
main






