#to check for pairs trips quads fhs iterate over all the cards in the hand (sorted) and count the instances of the same continous value

#returns a pair of ints, first one is the value of the quads, second the value of the high card
def quadVals(hand)
	val = hand[1][0]
	#if the middle three agree
	if hand[2][0]==val and hand[3][0] == val
		#if one of the ends agrees
		if hand[0][0] == val
			return [cardVal(val), cardVal(hand[4][0])]
		elsif hand[4][0] == val
			return [cardVal(val), cardVal(hand[0][0])]
		end
	end
	return [-1, -1]
end

#returns the value of the highest number in the straight, -1 otherwise
def straightVal(hand)
	val = cardVal(hand[0][0])
	hand.length.each do |i|
		if cardVal(hand[i][0]) != val+i
			return -1
		end
	end
	return val+4
end

#returns the values of the five cards (highest value first), -1 for all otherwise
def flushVal(hand)
	#compare first two cards
	if hand[0][1] == hand[1][1]
		#compare cards 2 and 3
		if hand[1][1] == hand [2][1]
			#compare cards 3 and 4
			if hand[2][1] == hand[3][1]
				#compare cards 4 and 5
				if hand[3][1] == hand[4][1]
					temp = Array.new
					5.times do |i|
						temp.push(cardVal(hand[4-i][1]))
					end
					return temp
				end
			end
		end	
	end
	temp = Array.new
	5.times do |i|
		temp.push(-1)
	end
	return temp
end

#returns the value of the house, trips and then pair. -1 for both otherwise
def houseVal(hand)
	if hand[0][0]==hand[1][0] and hand[2][0]==hand[3][0] and hand[3][0]==hand[4][0]
		return [cardVal(hand[2][0]), cardVal(hand[0][0])]
	elsif hand[3][0]==hand[4][0] and hand[0][0]==hand[1][0] and hand[1][0]==hand[2][0]
		return [cardVal(hand[0][0]), cardVal(hand[3][0])]
	end
	return [-1, -1]
end

#returns a triple, triple value first, then remaining cards in order of value
def tripVal(hand)
	3.each do |i|
		if hand[i][0] == hand[i+1][0] and hand[i+1][0] == hand[i+2][0]
			trip = cardVal(hand[i][0])
			case
			when i == 0
				return [trip, cardVal(hand[4][0]), cardVal(hand[3][0])]
			when i == 1
				return [trip, cardVal(hand[4][0]), cardVal(hand[0][0])]
			when i == 2
				return [trip, cardVal(hand[1][0]), cardVal(hand[0][0])]
			end
		end
	end
	return [-1, -1, -1]
end

#returns triple, top pair first, second pair second, high card third
def twoPairVal(hand)
	if hand[0][0] == hand[1][0]
		if hand[2][0] == hand[3][0]
			return [cardVal(hand[2][0]), cardVal(hand[0][0]), cardVal(hand[4][0])]
		elsif hand[3][0] == hand[4][0]
			return [cardVal(hand[3][0]), cardVal(hand[0][0]), cardVal(hand[2][0])]
		end
	elsif hand[1][0] == hand[2][0] and hand[3][0]==hand[4][0]
		return [cardVal(hand[3][0]), cardVal(hand[1][0]), cardVal(hand[0][0])]
	end
	return [-1, -1, -1]
end

#returns a quad, first value is double, last 3 are high cards, highest to lowest
def pairVal(hand)
	4.times do |i|
		if cardVal(hand[i][0]) == cardVal(hand[i+1][0])
			arr = [cardVal(hand[i][0])]
			highcardsvals = hand.slice(i, i+1).reverse.each{|c| c = cardVal(c)}
			arr.append(highcardsvals)
			return arr
		end
	end
	return [-1, -1, -1, -1]
end

#list of cards by value, high to low
def highVal(hand)
	arr = Array.new
	4.downto(0) do |i|
		arr.push(cardVal(hand[i]))
	end
	return arr
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
#return true if a wins, false otherwise
def evalHand(handa, handb)
	handa = handa.sort{|a,b| cardVal(a) - cardVal(b)}
	handb = handb.sort{|a,b| cardVal(a) - cardVal(b)}
	
	straighta = straightVal(handa)
	straightb = straightVal(handb)
	flusha = flushVal(handa)
	flushb = flushVal(handb)
	
	#check for straight flush
	if straighta > 0 and flusha > 0
		if straightb > 0 and flushb > 0
			if straighta > straightb
				return true
			end
			return false
		else
			return true
		end
	elsif straightb > 0 and flushb > 0
		return false
	end
	
	#check for quads
	quada = quadVals(handa)
	quadb = quadVals(handb)
	if quada[0] > 0
		if quadb[0] > 0
			if quada[0] > quadb[0] or (quada[0]==quadb[0] and quada[1]>quadb[1])
				return true
			end
			return false
		end
		return true
	elsif quadb[0] > 0
		return false
	end
	
	#check for full house
	housea = houseVal(handa)
	houseb = houseVal(handb)
	if housea[0]>0
		if houseb[0]>0
			if housea[0] > houseb[0] or housea[0]==houseb[0] and housea[1] > houseb[1]
				return true
			end
			return false
		end
		return true
	end
	#check for flush
	if flusha[0] > 0
		if flushb[0] > 0
			5.times do |i|
				if flusha[i] > flushb[i]
					return true
				elsif flusha[i] < flushb[i]
					return false
				end
			end
			return false
		end
		return true
	elsif flushb[0] > 0
		return false
	end
	#check for straight
	if straighta > 0
		if straightb > 0
			return straighta > straightb
		end
		return true
	elsif straightb > 0
		return false
	end
	
	#check for trips
	tripa = tripVal(handa)
	tripb = tripVal(handb)
	if tripa[0] > 0
		if tripb[0] > 0
			return tripa[0] > tripb[0] or (tripa[0]==tripb[0] and tripa[1]>tripb[1]) or (tripa[0]==tripb[0] and tripa[1]==tripb[1] and tripa[2]>tripb[2])
		end
	elsif tripb[0] > 0
		return false
	end
	#check for 2 pair
	tpa = twoPairVal(handa)
	tpb = twoPairVal(handb)
	3.times do |i|
		if tpa[i] > tpb[i]
			return true
		elsif tpb[i] > tpa[i]
			return false
		end
	end
	#check for pair
	paira = pairVal(handa)
	pairb = pairVal(handb)
	4.times do |i|
		if paira[i] > pairb[i]
			return true
		elsif pairb[i] > paira[i]
			return false
		end
	end
	#high card
	higha = highVal(handa)
	highb = highVal(handb)
	4.downto(0) do |i|
		if higha[i] > highb[i]
			return true
		elsif highb[i] > higha[i]
			return false
		end
	end
	return false
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