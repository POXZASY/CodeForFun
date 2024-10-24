file = File.open("Problem_22.txt")
$namelist = file.read.split(',').map{|n| n.delete('\"')}.sort
file.close

$total = 0

$namelist.each_with_index{ |n, i|
	letters = n.split('')
	lettertotalval = 0
	letters.each{ |ltr|
		lettertotalval+=ltr.ord-64
	}
	$total+=lettertotalval*(i+1)
}

puts "Solution: " + $total.to_s