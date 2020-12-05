from vec3 cimport *
import numpy as np
cimport numpy as np

cdef class Ray:
    cdef public vec3 pos
    cdef public vec3 dir

    cpdef vec3 point_at_param(self, double t)
    cpdef int hit_sphere(self, sphere)
