import cv2

img = cv2.imread('../img/noisyimg.jpg')
imgResize = cv2.resize(img, (256, 256))
cv2.imwrite('noisyimg256x256.png', imgResize)