require 'set'

$triangle_nums = Set.new
$square_nums = Set.new
$pentagonal_nums = Set.new
$hexagonal_nums = Set.new
$heptagonal_nums = Set.new
$octagonal_nums = Set.new

#a and b four digits numbers
def isCyclic(a, b)
	return a%100 == b/100
end

def main
	#generate all 4-digit numbers of each type
	n = 1
	while true
		trinum = n * (n+1) / 2
		sqnum = n**2
		ptnum = n * (3*n - 1) / 2
		hxnum = n * (2* n - 1)
		hpnum = n * (5 * n - 3) / 2
		octnum = n * (3 * n - 2)
		$triangle_nums.add(trinum) if trinum >= 1000 and trinum < 10000
		$square_nums.add(sqnum) if sqnum >= 1000 and sqnum < 10000
		$pentagonal_nums.add(ptnum) if ptnum >= 1000 and ptnum < 10000
		$hexagonal_nums.add(hxnum) if hxnum >= 1000 and hxnum < 10000
		$heptagonal_nums.add(hpnum) if hpnum >= 1000 and hpnum < 10000
		$octagonal_nums.add(octnum) if octnum >= 1000 and octnum < 10000
		
		break if trinum >= 10000 and sqnum >= 10000 and ptnum >= 10000 and hxnum >= 10000 and hpnum >= 10000 and octnum >= 10000
		
		n += 1
	end
	
	#iterate over each ordering
	all_nums = Array.new
	all_nums.push($triangle_nums)
	all_nums.push($square_nums)
	all_nums.push($pentagonal_nums)
	all_nums.push($hexagonal_nums)
	all_nums.push($heptagonal_nums)
	all_nums.push($octagonal_nums)
	#check for a solution in the given ordering
	(0...6).each do |i|
		(0...6).each do |j|
			next if j == i
			(0...6).each do |k|
				next if k == i or k == j
				(0...6).each do |x|
					next if x == i or x == j or x == k
					(0...6).each do |y|
						next if y == i or y == j or y == k or y == x
						(0...6).each do |z|
							next if z == i or z == j or z == k or z == x or z == y
							all_nums[i].each do |a|
								all_nums[j].each do |b|
									next if !isCyclic(a, b)
									all_nums[k].each do |c|
										next if !isCyclic(b, c)
										all_nums[x].each do |d|
											next if !isCyclic(c, d)
											all_nums[y].each do |e|
												next if !isCyclic(d, e)
												all_nums[z].each do |f|
													next if !isCyclic(e, f)
													next if !isCyclic(f, a)
													puts "Solution: " << (a + b + c + d + e + f).to_s
													return
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

t1 = Time.now
main
t2 = Time.now
puts "Time for program to run: " << (t2 - t1).to_s + " seconds"