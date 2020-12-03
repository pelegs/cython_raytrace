from vec3 cimport vec3

cdef class Sphere:
    cdef public vec3 center
    cdef public double rad
