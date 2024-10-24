import math
def isPrime(num):
    for i in range(2, int(math.sqrt(num)+2)):
        if num%i==0:
            return False
    return True


solved=False
val=3
totalprimes=1
while solved==False:
    if isPrime(val)==True:
        totalprimes+=1
        #print(val, totalprimes)
        if totalprimes==10001:
            print("ANSWER:", val,totalprimes)
            solved=True
    val+=1
    
