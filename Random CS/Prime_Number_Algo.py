import math
import timeit

#Testing algorithms to find all the primes up to a certain N
#Naive
def naivePrime(N):
    primes = []
    for i in range(2, N+1):
        shouldPrint = True
        for j in range(2, int(math.sqrt(i))+1):
            if((i%j)==0):
                shouldPrint = False
        if(shouldPrint):
            primes.append(i)
    ##for p in primes:
        ##print(p)
#Storing primes as we get them
def basicStorage(N):
    primes = []
    for i in range(2, N+1):
        primenum = True
        for p in primes:
            if(i%p==0):
                primenum = False
        if(primenum):
            primes.append(i)
    ##for p in primes:
        ##print(p)
def sieveOfEratosthenes(N):
    #make the list of integers
    primes = []
    for i in range(2, N+1):
        primes.append(i)
    #remove multiples of primes
    inc = 0
    while(primes[inc] <= math.sqrt(N)):
        valstoremove=[]
        #iterate from inc to end of primes
        for i in range(inc+1, len(primes)):
            #if inc divides one of the numbers, add it to remove list
            if(primes[i]%primes[inc]==0):
                valstoremove.append(primes[i])
        #remove the found multiples
        for v in valstoremove:
            primes.remove(v)
        inc+=1
    
    ##for i in primes:
        ##print(i)
def sieveOfEratosthenes2(N):
    primes = []
    for i in range(2, N+1):
        primes.append(i)
    inc = 0 #location of base value
    while(inc < len(primes)-1 and primes[inc] <= math.sqrt(N)):
        for p in primes:
            print(p)
        tempval = primes[inc]
        tempinc = inc+tempval #location of multiple values
        while(tempinc < len(primes)):
            primes.remove(primes[tempinc])
            tempinc = tempinc + tempval
        inc+=1
    for p in primes:
        print(p)


##############################################        
def wrapper(func, *args, **kwargs):
    def wrapped():
        return func(*args, **kwargs)
    return wrapped
def main():
    num = 20
    print("-------------------------")
    func = wrapper(naivePrime, num)
    print(timeit.timeit(func, number=1))
    print("-------------------------")
    func = wrapper(basicStorage, num)
    print(timeit.timeit(func, number=1))
    print("-------------------------")
    func = wrapper(sieveOfEratosthenes, num)
    print(timeit.timeit(func, number=1))
    print("-------------------------")
    func = wrapper(sieveOfEratosthenes2, num)
    print(timeit.timeit(func, number=1))
main()
