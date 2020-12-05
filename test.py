#!/usr/bin/env python3
# -*- coding: iso-8859-15 -*-

"""
Testing the libraries, nothing fancy.
"""

from lib.constants import *
from lib.vec3 import *
from lib.matrix33 import *
from lib.ray import Ray
from lib.image import mat_to_img
from lib.camera import Camera
import numpy as np

def rotate_np(k):
    K = np.array([[0,-k[2],k[1]],
                  [k[2],0,-k[0]],
                  [-k[1],k[0],0]])
    return np.identity(3) + np.dot(K, K)

v1_arr = np.random.uniform(size=3)
v2_arr = np.random.uniform(size=3)
v1 = from_np(v1_arr).normalize()
v2 = from_np(v2_arr).normalize()

v3 = rotate_dir((v1+v2)/2, np.pi) * v1
print(v1)
print(v2)
print(v3)

v1_arr = v1_arr / np.linalg.norm(v1_arr)
v2_arr = v2_arr / np.linalg.norm(v2_arr)
v3_arr = rotate_np((v1_arr+v2_arr)/2).dot(v1_arr)
print(v1_arr)
print(v2_arr)
print(v3_arr)
