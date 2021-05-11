def digitSum(n)
    sum = 0
    while n > 0
        digit = n % 10
        sum += digit
        n = (n - digit) / 10
    end
    sum
end

def main
    maxsum = 0
    (1..100).each do |a|
        (1..100).each do |b|
            digitsum = digitSum(a**b)
            maxsum = digitsum if digitsum > maxsum
        end
    end
    puts "Solution: " << maxsum.to_s
end
main