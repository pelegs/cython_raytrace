from vec3 cimport *
import numpy as np
cimport numpy as np
from libc.math cimport sqrt

cdef class Ray:
    cdef public vec3 pos
    cdef public vec3 dir

    cpdef vec3 point_at_param(self, double t)
    cpdef double hit_sphere(self, sphere)
    cpdef vec3 sphere_color(self, sphere)
