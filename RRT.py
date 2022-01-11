import cv2
import csv
import numpy as np
import os
import time

size = (800,800)
blank_page = np.zeros((size[0],size[1],3), np.uint8)
blank_page.fill(255)
radius = 30
obstacles = list()
nodes = list()

# ==============================================================================
def remove(thing):
    removed = thing[-1][:]
    cv2.circle(blank_page, (removed[0], removed[1]), removed[2], (255,255,255), -1)
    thing.pop()

def callback1(event, x, y, flag, param):
    global radius,obstacles

    if event == cv2.EVENT_LBUTTONDBLCLK:
        cv2.circle(blank_page, (x,y), radius, (0,0,0), -1)   
        obstacles.append([x,y,radius])
        print("the mouse double clicked at : ",x,y)

def callback2(event, x, y, flag, param):
    global radius,nodes

    if event == cv2.EVENT_LBUTTONDBLCLK:
        cv2.circle(blank_page, (x,y), radius, (0,0,255), -1)   
        nodes.append([x,y,radius])
        print("the mouse double clicked at : ",x,y)


cv2.namedWindow('mark obstacles',cv2.WINDOW_AUTOSIZE)  
cv2.setMouseCallback('mark obstacles',callback1)

while True:

    cv2.imshow('mark obstacles',blank_page)
    
    ret = cv2.waitKey(1) & 0xFF
    if ret == -1:
        continue
    elif ret == 27:
        break
    elif ret == ord('+'):
        radius += 1
        print('radius of circle :',radius)
    elif ret == ord('-'):
        radius -= 1
        print('radius of circle :',radius)
    elif ret == ord('z'):
        remove(obstacles)


cv2.destroyAllWindows()

cv2.namedWindow('mark nodes',cv2.WINDOW_AUTOSIZE)  
cv2.setMouseCallback('mark nodes',callback2)

while True:

    cv2.imshow('mark nodes',blank_page)
    
    ret = cv2.waitKey(1) & 0xFF
    if ret == -1:
        continue
    elif ret == 27:
        break
    elif ret == ord('+'):
        radius += 1
        print('radius of circle :',radius)
    elif ret == ord('-'):
        radius -= 1
        print('radius of circle :',radius)
    elif ret == ord('z'):
        remove(nodes)


cv2.destroyAllWindows()

start = time.perf_counter()

for x in nodes:
    x[1] = 800 - x[1]

for x in obstacles:
    x[1] = 800 - x[1]
    x[2] = x[2] + 3 

with open('obstacles.csv','w') as obs:
    obsCsv = csv.writer(obs)
    obsCsv.writerows(obstacles)

with open('SGnodes.csv','w') as n: 
    nCsv = csv.writer(n)
    nCsv.writerows(nodes)
# ============================================================================

os.system('octave driver.m')

# ============================================================================

nodes = []
path = []
edges = []

with open('nodes.csv') as csvNodes:
    nodesReader = csv.reader(csvNodes, delimiter=',')
    for row in nodesReader:
        nodes.append([int(float(x)) for x in row])

with open('edges.csv') as csvEdges:
    Reader = csv.reader(csvEdges, delimiter=',')
    for row in Reader:
        edges.append([int(float(x)) for x in row])

with open('path.csv') as csvPath:
    Reader = csv.reader(csvPath, delimiter=',')
    for row in Reader:
        for x in row:
            path.append(int(x))

#===========================================


for x in nodes:
    x[2] = 800 - x[2]

nodeRadius = 4
edgeWidth = 2


for node in nodes:
    cv2.circle(blank_page, (node[1],node[2]), nodeRadius, (255,0,0), -1, cv2.LINE_AA)

for edge in edges:

    point1 = ( nodes[ edge[0] - 1 ][ 1 ], nodes[ edge[0] - 1 ][2] )
    point2 = ( nodes[ edge[1] - 1 ][ 1 ], nodes[ edge[1] - 1 ][2] )
    
    cv2.line(blank_page, point1, point2, (0,255,0), edgeWidth, cv2.LINE_AA )


# for i in range(0,len(path)-2):

#     point1 = ( nodes[ path[i] ][ 1 ], nodes[ path[i] ][2] )
#     point2 = ( nodes[ path[i+1] ][ 1 ], nodes[ path[i+1] ][2] )
    
#     cv2.line(blank_page, point1, point2, (0,0,255), edgeWidth, cv2.LINE_AA )

# point1 = ( nodes[ path[1] ][ 1 ], nodes[ path[1] ][2] )
# point2 = ( nodes[ path[2] ][ 1 ], nodes[ path[2] ][2] )
# cv2.line(blank_page, point1, point2, (0,0,255), edgeWidth, cv2.LINE_AA )




cv2.imshow('RRT', blank_page)
print('execution time = ', time.perf_counter() - start )
cv2.waitKey(0)
cv2.destroyAllWindows()

