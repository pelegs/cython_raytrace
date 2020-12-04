#!/usr/bin/env python3
# -*- coding: iso-8859-15 -*-

"""
Testing the libraries, nothing fancy.
"""

from lib.vec3 import *
from lib.matrix33 import *
from lib.ray import Ray
from lib.image import mat_to_img
from lib.camera import Camera
import numpy as np

mat1 = Matrix33(2*x_, 0.5*y_, -3*z_)
mat2 = Matrix33(2*x_, 2*y_, 2*z_)
v1 = vec3(1,3,7)
print(mat1*2)
print(2*mat1)

print(rotate_mat(x=0, y=np.pi/2, z=0))
