#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3


cdef class Sphere:
    def __init__(self, center=origVec, rad=1):
        self.center = center
        self.rad = rad
