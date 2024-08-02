# This sequence can be represented recursively:
# n_k = a_k + 1 / n_k+1
# and n_0 = a_0 + 1 / n_1
# then:
# n_0 = a_0 + 1 / (a_1 + 1 / n_2) etc.
# and thus, n_0 = sqrt(N).

# Given a value n_k, break it into the form a_k + 1 / n_k+1
# and return the tuple [a_k, n_k+1]
def get_int_and_denom(nk)
	# TODO how
end

# Get the length of the period
def get_period(N)
	# Maps the int, denom pair to when it was found
	int_and_denom_map = Hash.new

	# Loop until [int, denom] repeats
	nk = N
	while true
		current_int_and_denom = get_int_and_denom(nk)

		# If we've already found this pair, return how long ago
		if int_and_denom_map.include? current_int_and_denom
			# length of the cycle
			return int_and_denom_map.size - int_and_denom_map[current_int_and_denom]
		end

		# Otherwise, add it to the list and continue
		int_and_denom_map[current_int_and_denom] = int_and_denom_map.size
		nk = current_int_and_denom[1]
	end
end

def main
	num_odd_periods = 0
	2..10000.each do |i|
		# Only count irrational roots
		root = Math.sqrt(i)
		next if root > root.to_i

		# Add to the counter if the period is odd
		num_odd_periods += 1 if get_period(i).odd?
	end

	puts num_odd_periods
end

main