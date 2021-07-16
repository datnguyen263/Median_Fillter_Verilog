import numpy as np
import cv2

array=[]
f = open('test_gray.txt','r')
for i in f:
    array.append(i)
f.close()

# Remove /n
array = list(map(lambda s: s.strip(),array))
#Choose pixel Image
# img = cv2.imread('E:\\Junior_Third_Year\\CD_TK_VM_1\\CE434.L21_Group_6\\Task4\\LAB4_PY\\256x256.png') 
# pixel = img.shape
width, height =(256,256)


# Tao mang de save sau cung ve mang 2 chieu
binary_array = []
address = 0 
for i in range(width):
    # tao mang tam thoi de ket hop thanh mang 2 chieu
    temporary = [];
    for j in range(height):
        temporary.append(int(array[j + address],2))
        if j != (height - 1):
            continue
        else:
            address = j + 1 + address # Su dung bien tam de luu cac dia chi tiep theo can tach
    # Add mang 1 chieu vao
    binary_array.append(temporary)
# Convert list to np.array
binary_array = np.array(binary_array)

cv2.imwrite('test.png',binary_array)
cv2.imread('test.png',cv2.IMREAD_UNCHANGED)

print('~DONE~')
