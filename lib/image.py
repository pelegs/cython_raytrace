#!/usr/bin/env python3
# -*- coding: iso-8859-15 -*-

import cv2
import numpy as np
from numpy import arcsin, arctan2, pi
from .vec3 import *
from .constants import pi2

def mat_to_img(mat, filename='out.png'):
    cv2.imwrite(filename, np.array(mat))

def uvw_map(v, w, h):
    u = int((0.5 + arctan2(v.x, v.z)/pi2)*w-1)
    v = int((0.5 - arcsin(v.y)/pi)*h-1)
    return u, v
