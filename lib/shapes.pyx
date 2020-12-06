import numpy as np
cimport numpy as np
#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3

cdef class Sphere:
    def __init__(self, center=origVec, rad=1.0, color=np.array([255,255,255])):
        self.center = center
        self.rad = rad
        self.color = color
