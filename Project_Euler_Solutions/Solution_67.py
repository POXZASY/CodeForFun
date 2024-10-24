#list of lists, each list is a row of the pyramid
with open("Problem_67.txt") as f:
    pyramid = f.readlines()
pyramid = [i.strip().split(" ") for i in pyramid]
for i in pyramid:
    for j in i:
        j=int(j)
#print(pyramid)
