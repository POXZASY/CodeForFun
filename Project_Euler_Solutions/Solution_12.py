def numOfFactors(num):
    count=0
    for i in range(1,int(num/2)):
        if num%i==0:
            count+=1
    return count

def triNum(num):
    val=0
    for i in range(1,num+1):
        val=val+i
    return val

base=10
adder=1
largestfacts=0
halving=False
data=0
pts=0
while True:
    result=numOfFactors(triNum(base))
    if result > largestfacts:
        largestfacts=result
    base+=1
    
    data=data+(triNum(base)/result)
    pts=pts+1
    avg=data/pts
    print(int(avg))
