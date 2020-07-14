total = 0
(1..((9**5)*6)).each do |i|
	digittotal = 0
	i.to_s.split('').map{|j| j.to_i }.each do |k|
		digittotal+=k**5
	end
	if digittotal==i
		total+=i
	end
end
total = total-1 #don't include 1
puts "Solution: "+total.to_s