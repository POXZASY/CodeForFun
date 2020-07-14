def func():
    total = 1 #we manually include the middle
    currentnum = 1
    inc = 2
    for i in range(3, 1002, 2): #iterate through every "box"
        incposition = 0 #0 to 3
        while incposition < 4: #add each of the four edges in each "box"
            currentnum += inc
            total += currentnum
            
            incposition+=1
        inc+=2

    print(total)
func()
    
