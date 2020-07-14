for a in range(1000):
    for b in range(a+1,1000):
        if(a**2+b**2==(1000-a-b)**2) and (1000-a-b)>b:
            print(a*b*(1000-a-b))
