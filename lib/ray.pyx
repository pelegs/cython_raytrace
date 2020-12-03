from vec3 cimport vec3
import numpy as np
cimport numpy as np
#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3

cdef class Ray:
    """
    A ray to be traced.
    """
    cdef public vec3 pos
    cdef public vec3 dir
    
    def __init__(self, pos, dir):
        self.pos = pos
        self.dir = dir

    cpdef vec3 point_at_param(self, double t=1.0):
        return self.pos + t * self.dir

    cpdef int hit_sphere(self, sphere):
        cdef double r = sphere.rad
        cdef vec3 C = sphere.center
        cdef vec3 A = self.pos
        cdef vec3 B = self.dir
        cdef double a = B.sqr_norm()
        cdef double b = B.dot(A-C)
        cdef double c = (A-C).sqr_norm - r**2
        return b**2 >= a*c
