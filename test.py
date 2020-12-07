#!/usr/bin/env python3
# -*- coding: iso-8859-15 -*-

from lib.vec3 import *
from lib.camera import Camera
from lib.shapes import Sphere

sphere = Sphere(center=vec3(4,0,0), image='maps/earth.jpg')
cam = Camera(pos=orig, dir=-x_)
cam.test_render(sphere)
cam.save_img('images/uvw_test1.png')
