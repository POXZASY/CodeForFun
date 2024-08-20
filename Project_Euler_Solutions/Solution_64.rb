# This sequence can be represented recursively:
# n_k = a_k + 1 / n_k+1
# and n_0 = a_0 + 1 / n_1
# then:
# n_0 = a_0 + 1 / (a_1 + 1 / n_2) etc.
# and thus, n_0 = sqrt(N).
# https://math.stackexchange.com/questions/265690/continued-fraction-of-a-square-root

require 'bigdecimal'

PRECISION = 300

# Given a value n_k, break it into the form a_k + 1 / n_k+1
# and return the tuple [a_k, n_k+1]
def get_int_and_denom(nk)
	# leading constant
	ak = nk.to_i
	# denominator
	nk1 = 1 / (nk - ak)
	return [ak, nk1]
end

# Get the length of the period
def get_period(n0)
	# Maps the int, denom pair to when it was found
	int_and_rounded_denom_map = Hash.new

	# Loop until [int, denom] repeats
	nk = n0
	while true
		current_int_and_denom = get_int_and_denom(nk)
		# the map must be indexed with rounded denominators to avoid floating point errors
		current_int_and_rounded_denom = [current_int_and_denom[0], current_int_and_denom[1].round(6)]

		# If we've already found this pair, return how long ago
		if int_and_rounded_denom_map.include? current_int_and_rounded_denom
			# length of the cycle
			return int_and_rounded_denom_map.size - int_and_rounded_denom_map[current_int_and_rounded_denom]
		end

		# Otherwise, add it to the list and continue
		int_and_rounded_denom_map[current_int_and_rounded_denom] = int_and_rounded_denom_map.size
		nk = current_int_and_denom[1]
	end
end

def main
	BigDecimal.limit(PRECISION)
	num_odd_periods = 0
	(2..10000).each do |i|
		# Only count irrational roots
		root = BigDecimal(i.to_s).sqrt(PRECISION)
		next if root == root.to_i

		# Add to the counter if the period is odd
		period = get_period(root)
		num_odd_periods += 1 if period.odd?
	end

	puts num_odd_periods
end

main