require 'set'

def isPrime(n, primes)
    primes.each do |p|
        break if p**2 > n
        return false if n%p == 0
    end
    true
end

def main
    #prime vars
    primes = Set[2]
    maxprime = 2
    potentialprime = 3
    
    corners = Array.new
    n = 1
    adder = 2
    length = 1

    numprimecorners = 0
    numcorners = 1
    while true
        #length of the new square being investigated
        length += 2
        #update prime list if not large enough
        while n + 4*(adder) > maxprime**2
            if isPrime(potentialprime, primes)
                primes.add(potentialprime)
                maxprime = potentialprime
            end
            potentialprime += 2
        end

        4.times do
            n += adder
            corners.push(n)
            numprimecorners += 1 if isPrime(n, primes)
        end
        numcorners += 4
        #get the ratio of primes
        break if numprimecorners.to_f/numcorners < 0.1
        adder += 2
    end
    puts "Solution: " << length.to_s
end
main