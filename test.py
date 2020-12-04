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

#m_arr = np.random.uniform(size=(3,3))
#v_arr = np.random.uniform(size=3)
m_arr = np.array([[ 5, 1 ,3], 
                  [ 1, 1 ,1], 
                  [ 1, 2 ,1]]).astype(np.float64)
v_arr = np.array([1, 2, 3]).astype(np.float64)
print(m_arr)
print(v_arr)
print(m_arr.dot(v_arr))

m = from_np(m_arr)
v = from_np(v_arr)
print(m)
print(v)
print(m*v)

v = rotate_mat(np.pi/2,np.pi/2,0) * (-z_)
print(v)
