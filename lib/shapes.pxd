from vec3 cimport *

cdef class Sphere:
    cdef public vec3 center
    cdef public double rad
    cdef public long[:] color
