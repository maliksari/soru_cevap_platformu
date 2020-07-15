# benzerlik ölçümü
import numpy as np


def benzer(s, t, ratio_calc = False):
    
    
    
    rows = len(s)+1
    cols = len(t)+1
    distance = np.zeros((rows,cols),dtype = int)

    
    for i in range(1, rows):
        for k in range(1,cols):
            distance[i][0] = i
            distance[0][k] = k

     
    for col in range(1, cols):
        for row in range(1, rows):
            if s[row-1] == t[col-1]:
                cost = 0 
            else:
                if ratio_calc == True:
                    cost = 2
                else:
                    cost = 1
            distance[row][col] = min(distance[row-1][col] + 1,     
                                 distance[row][col-1] + 1,         
                                 distance[row-1][col-1] + cost)     
    if ratio_calc == True:
        
        Ratio = ((len(s)+len(t)) - distance[row][col]) / (len(s)+len(t))
        return Ratio
    else:
       
        return "The strings are {} edits away".format(distance[row][col])

"""
a = "malik sari"
b = "malik"

print(benzer(a,b,ratio_calc=True))


"""
