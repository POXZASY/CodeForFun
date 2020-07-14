import math
def isCurious(n):
    total = 0
    for i in range(len(str(n))):
        total+= math.factorial(int(str(n)[i]))
    return total==int(n)

#2.8 mil is 7 digits. 9! is < 400000, so the curious val of vals above 6 digits
#cannot be more than 2.8mil, which is less than all these numbers

def main():
    total = 0
    for i in range(2800000):
        if(isCurious(i)):
            total+=i
    print(total-3) #subtract 1! and 2!
main()
