#!/usr/bin/env python3
# -*- coding: iso-8859-15 -*-

"""
Testing the libraries, nothing fancy.
"""

from lib.vec3 import vec3
from lib.ray import Ray
from lib.image import mat_to_img
import numpy as np

w, h = 500, 500
mat = (np.array([[[float(i)/w, float(j)/h, 0.25]
                  for i in range(1, w+1)]
                  for j in range(h+1, 1, -1)]) * 255).astype(int)
mat_to_img(mat, 'test.png')
