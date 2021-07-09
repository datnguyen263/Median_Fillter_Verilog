import cv2 
import numpy as np
from numpy.core.numeric import binary_repr
import os

image = cv2.imread('../img/noisyimg.png')
print(image)
img = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
print ('Shape Original image : ',img.shape)

# Convert Decimal to Binary with width size 8
binary_repr_v = np.vectorize(np.binary_repr)
abc = binary_repr_v(img,8)
print(abc.shape)
print(abc)
# Save
np.savetxt("data.txt", abc, delimiter=" ", newline = "\n", fmt="%s")
print("SAVE DONE")