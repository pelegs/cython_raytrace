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

arr = np.random.uniform(size=(3,3))
print(arr)
m = from_np(arr)
print(m)

print(np.linalg.det(arr))
print(m.det())
