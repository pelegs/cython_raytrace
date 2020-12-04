from numpy import float64 as npdouble
import numpy as np
cimport numpy as np
#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3

"""
Defines relevant 3x3 matrices
"""

cdef SCALARS = [int, float, npdouble]

cdef class Matrix33:
    def __init__(self, c1, c2, c3):
        self.c1 = c1
        self.c2 = c2
        self.c3 = c3
        
        # Rows (it helps with transpose and products)
        self.r1 = vec3(c1[0], c2[0], c3[0])
        self.r2 = vec3(c1[1], c2[1], c3[1])
        self.r3 = vec3(c1[2], c2[2], c3[2])

        # Specific elements (not sure it's useful)
        self.a11 = self[0][0]
        self.a12 = self[0][1]
        self.a13 = self[0][2]
        
        self.a21 = self.r1[1]
        self.a22 = self.r2[1]
        self.a23 = self.r3[1]
        
        self.a31 = self.r1[2]
        self.a32 = self.r2[2]
        self.a33 = self.r3[2]

    def __str__(self):
        return '({}\n {}\n {})'.format(self.c1,
                                     self.c2,
                                     self.c3)
    
    ####################
    # UNARY OPERATIONS #
    ####################
    
    def __pos__(self):
        return self

    def __neg__(self):
        return self.neg()

    cpdef Matrix33 neg(self):
        return -1*self
    
    def __getitem__(self, key):
        return [self.c1, self.c2, self.c3][key]

    cpdef Matrix33 transpose(self):
        return Matrix33(self.r1, self.r2, self.r3)

    cpdef double det(self):
        cdef double A = self.a11 * (self.a22*self.a33 - self.a23*self.a32)
        cdef double B = self.a12 * (self.a21*self.a33 - self.a23*self.a31)
        cdef double C = self.a13 * (self.a21*self.a32 - self.a22*self.a31)
        return A-B+C

    
    #####################
    # BINARY OPERATIONS #
    #####################
    
    # Equality
    def __eq__(self, m):
        return bool(self.eq(m))

    cpdef int eq(self, Matrix33 m):
        return (self.c1 == m.c1) and (self.c2 == m.c2) and (self.c3 == m.c3)

    # Addition
    def __add__(self, m):
        return self.add(m)

    cpdef Matrix33 add(self, Matrix33 m):
        return Matrix33(self.c1+m.c1, self.c2+m.c2, self.c3+m.c3)
    
    # Subtraction
    def __sub__(self, m):
        return self.sub(m)

    cpdef Matrix33 sub(self, Matrix33 m):
        return Matrix33(self.c1-m.c1, self.c2-m.c2, self.c3-m.c3)
    
    # Multiplication
    def __mul__(self, a):
        if type(self) in SCALARS:
            return a.mul_scalar(self) 
        if type(a) == Matrix33:
            return self.dot_mat(a)
        elif type(a) == vec3:
            return self.dot_vec(a)
        elif type(a) in SCALARS:
            return self.mul_scalar(a)

    cpdef Matrix33 mul_scalar(self, Scalar a):
        return Matrix33(self.c1*a, self.c2*a, self.c3*a)

    cpdef vec3 dot_vec(self, vec3 v):
        return vec3(self.c1.dot(v), self.c2.dot(v), self.c3.dot(v))

    cpdef Matrix33 dot_mat(self, Matrix33 m):
        return Matrix33(self.dot_vec(m.r1), self.dot_vec(m.r2), self.dot_vec(m.r3)).transpose()


cdef Matrix33 c_mat_from_np(np.ndarray[double, ndim=2] arr):
    cdef vec3 c1 = c_vec_from_np(arr[0,:])
    cdef vec3 c2 = c_vec_from_np(arr[1,:])
    cdef vec3 c3 = c_vec_from_np(arr[2,:])
    return Matrix33(c1, c2, c3)

cdef Matrix33 rotate_x(double ang):
    cdef double c = cos(ang)
    cdef double s = sin(ang)
    cdef vec3 c1 = vec3(1,0,0)
    cdef vec3 c2 = vec3(0,c,-s)
    cdef vec3 c3 = vec3(0,s,c)
    return Matrix33(c1, c2, c3)

cdef Matrix33 rotate_y(double ang):
    cdef double c = cos(ang)
    cdef double s = sin(ang)
    cdef vec3 c1 = vec3(c,0,s)
    cdef vec3 c2 = vec3(0,1,0)
    cdef vec3 c3 = vec3(-s,0,c)
    return Matrix33(c1, c2, c3)

cdef Matrix33 rotate_z(double ang):
    cdef double c = cos(ang)
    cdef double s = sin(ang)
    cdef vec3 c1 = vec3(c,-s,0)
    cdef vec3 c2 = vec3(s,c,0)
    cdef vec3 c3 = vec3(0,0,1)
    return Matrix33(c1, c2, c3)

cdef Matrix33 c_rotate(double x, double y, double z):
    return rotate_z(z) * rotate_y(y) * rotate_x(x)

# Python rappers

def from_np(arr):
    if arr.shape == (3,):
        return c_vec_from_np(arr)
    elif arr.shape == (3,3):
        return c_mat_from_np(arr)
    else:
        return None

def rotate_mat(x=0, y=0, z=0):
    return c_rotate(x, y, z)
