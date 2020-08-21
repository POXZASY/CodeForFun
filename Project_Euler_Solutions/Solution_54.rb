#to check for pairs trips quads fhs iterate over all the cards in the hand (sorted) and count the instances of the same continous value


#returns the value of the highest number in the straight, -1 otherwise
def straightVal(hand)

end

def isFlush(hand)
	#compare first two cards
	if hand[0][1] == hand[1][1]
		#compare cards 2 and 3
		if hand[1][1] == hand [2][1]
			#compare cards 3 and 4
			if hand[2][1] == hand[3][1]
				#compare cards 4 and 5
				return hand[3][1] == hand[4][1]
			end
		end	
	end
	return false
end

#gets the value (not the suit) of the given card
def cardVal(card)
	cardval = card[0]
	cardint = cardval.to_i
	if cardint != 0
		return cardint
	end
	case cardval
	when 'T'
		return 10
	when 'J'
		return 11
	when 'Q'
		return 12
	when 'K'
		return 13
	when 'A'
		return 14
	end
end

#hands are arrays of two characters representing cards
def evalHand(handa, handb)
	p handa.sort{|a,b| cardVal(a) - cardVal(b)}
end


def main
	file = File.open("Problem_54.txt")
	lines = file.readlines
	count = 0
	lines.each do |line|
		cards = line.split(" ")
		handa = cards[0..4]
		handb = cards[5..9]
		if evalHand(handa, handb)
			count += 1
		end
		break
	end
	puts "Solution: #{count}"
end

main