from vec3 cimport vec3
#import numpy as np
#cimport numpy as np
#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3


cdef class Sphere:
    def __init__(self, center=origVec,0,0), rad=1):
        self.center = center
        self.rad = rad
