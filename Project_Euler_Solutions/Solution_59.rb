def has_word(word, arr)
	(0..arr.length-word.length).each do |i|
		foundWord = true
		word.length.times do |j|
			if word[j]!=arr[i+j].chr
				foundWord = false
				break
			end
		end
		return true if foundWord
	end
	false
end

def main
	file = File.open("Problem_59.txt")
	chars = file.read.split(",").map{|i| i.to_i}
	(97..122).each do |x|
		(97..122).each do |y|
			(97..122).each do |z|
				key = [x, y, z]
				newchars = chars.clone
				#get the new ascii values
				chars.length.times do |i|
					newchars[i] = newchars[i] ^ key[i%3]
				end
				#check for any bad ascii values
				badwords = false
				newchars.each do |c|
					badwords = true if (c < 32 or c > 122)
				end
				next if badwords
				#check if the or and is in the statement
				if has_word("the", newchars) and has_word("and", newchars)
					asciisum = 0
					newchars.each{|c| asciisum += c}
					puts "Sum of ascii: " << asciisum.to_s
					p newchars.map{|c| c.chr}.join
				end
			end
		end
	end	
end

main