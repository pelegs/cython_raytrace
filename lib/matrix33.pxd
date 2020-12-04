from vec3 cimport *
cimport numpy as np
from libc.math cimport sin, cos

cdef class Matrix33:
    cdef vec3 c1
    cdef vec3 c2
    cdef vec3 c3
    
    cpdef Matrix33 add(self, Matrix33 m)
    cpdef Matrix33 sub(self, Matrix33 m)
    cpdef vec3 dot_vec(self, vec3 v)
    cpdef Matrix33 dot_mat(self, Matrix33 m)


cdef Matrix33 identity = Matrix33(xhat, yhat, zhat)
cdef Matrix33 rotate_x(double ang)
cdef Matrix33 rotate_y(double ang)
cdef Matrix33 rotate_z(double ang)
