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
from lib.shapes import Sphere
import numpy as np


sphere = Sphere(center=vec3(0,0,6))
cam = Camera()
for f in range(100):
    cam.rotate(0, pi/200)
    cam.test_render(sphere)
    mat_to_img(cam.image, filename='../images/rotate/{:03d}.png'.format(f))
