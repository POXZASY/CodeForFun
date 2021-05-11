def main
    count = 0
    n = Rational(1, 2)
    1000.times do
        count += 1 if (n+1).denominator.to_s.length < (n+1).numerator.to_s.length
        n = 1 / (2 + n)
    end
    puts "Solution: " << count.to_s
end
main