import math
def isPrime(num):
    for i in range(2,int(math.sqrt(num)+2)):
        if num%i==0:
            return False
    return True
total=2
for j in range(3,2000000):
    if isPrime(j)==True:
        total+=j
print(total)
