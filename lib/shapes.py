from cv2 import imread
import numpy as np
from .vec3 import *
from .matrix33 import *
from .image import uvw_map

class Sphere:
    def __init__(self, center=orig, rad=1.0,
                 color=np.array([255,255,255]),
                 image=None):
        self.center = center
        self.rad = rad
        self.color = color
        self.image = imread(image)
        self.img_w = self.image.shape[0]
        self.img_h = self.image.shape[1]

    def uvw_image(self, n=x_):
        u, v = uvw_map(n, self.img_w, self.img_h)
        return self.image[u,v]
