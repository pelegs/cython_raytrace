from vec3 cimport *
cimport numpy as np
import numpy as np
cimport cython
from libc.math cimport sin, cos

ctypedef fused Scalar:
    cython.int
    cython.float
    cython.double

cdef class Matrix33:
    cdef public vec3 c1
    cdef public vec3 c2
    cdef public vec3 c3
    cdef public vec3 r1
    cdef public vec3 r2
    cdef public vec3 r3
    cdef public double a11
    cdef public double a12
    cdef public double a13
    cdef public double a21
    cdef public double a22
    cdef public double a23
    cdef public double a31
    cdef public double a32
    cdef public double a33
    
    cpdef Matrix33 neg(self)
    cpdef Matrix33 transpose(self)
    cpdef int eq(self, Matrix33 m)
    cpdef double det(self)
    cpdef Matrix33 add(self, Matrix33 m)
    cpdef Matrix33 sub(self, Matrix33 m)
    cpdef Matrix33 mul_scalar(self, Scalar a)
    cpdef vec3 dot_vec(self, vec3 v)
    cpdef Matrix33 dot_mat(self, Matrix33 m)

cdef Matrix33 c_mat_from_np(np.ndarray[double, ndim=2] arr)
cdef Matrix33 identity = Matrix33(xhat, yhat, zhat)
cdef Matrix33 rotate_x(double ang)
cdef Matrix33 rotate_y(double ang)
cdef Matrix33 rotate_z(double ang)
