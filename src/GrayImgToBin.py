import cv2
# path
path = r'noisyimg256x256.png'
  
img = cv2.imread(path, 0)
print(img.shape)
img_txt = img.flatten()
print(img_txt)
with open(r'test_gray.txt', 'w') as f:
    for x in img_txt:
        bnr = bin(int(x)).replace('0b','')
        y = bnr[::-1] 
        while len(y) < 8:
            y += '0'
        bnr = y[::-1]
        f.write(bnr+"\n")
f.close()