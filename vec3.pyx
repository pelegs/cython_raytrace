from __future__ import print_function
import numpy as np
from numpy import exp as npexp
from numpy import sqrt as npsqrt
cimport numpy as np
from libc.math cimport sqrt, abs, exp
#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3

"""
Defines 3-vectors and their operations.
"""

cdef class vec3:
    """
    A 3-vector with real x, y, z components.
    """
    cdef public double  x
    cdef public double  y
    cdef public double  z

    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def __str__(self):
        # Print the vector to stdout
        return '({},{},{})'.format(self.x, self.y, self.z)
    
    ####################
    # UNARY OPERATIONS #
    ####################

    def __pos__(self):
        return self

    def __neg__(self):
        return self.neg()

    cpdef vec3 neg(self):
        return -1*self

    #####################
    # BINARY OPERATIONS #
    #####################

    # Addition
    def __add__(self, v):
        return self.add(v)

    cpdef vec3 add(self, vec3 v):
        return vec3(self.x+v.x, self.y+v.y, self.z+v.z)
    
    # Subtraction
    def __sub__(self, v):
        return self.sub(v)

    cpdef vec3 sub(self, vec3 v):
        return vec3(self.x-v.x, self.y-v.y, self.z-v.z)

    # Multiplication
    def __mul__(self, a):
        if type(self) == vec3:
            return self.mul(a)
        else:
            return a.mul(self)

    cpdef vec3 mul(self, double a):
        return vec3(self.x*a, self.y*a, self.z*a)
    
    # Division
    def __truediv__(self, a):
        return self.div(a)

    cpdef vec3 div(self, double a):
        if a == 0:
            import warnings
            warnings.warn('Division by 0, returning the original vec3.')
            return self
        else:
            return vec3(self.x/a, self.y/a, self.z/a)

    # Power
    def __pow__(self, a, b):
        return self.pow(a)

    cpdef vec3 pow(self, double a):
        return vec3(self.x**a, self.y**a, self.z**a)

    ###############
    # COMPARISONS #
    ###############

    def __eq__(self, v):
        return (self.x == v.x) and (self.y == v.y) and (self.z == v.z)
    
    def __ne__(self, v):
        return not self.__eq__(v)
    
    def __lt__(self, v):
        return self.sqr_norm() < v.sqr_norm()
    
    def __le__(self, v):
        return self.sqr_norm() <= v.sqr_norm()
    
    def __gt__(self, v):
        return self.sqr_norm() > v.sqr_norm()
    
    def __ge__(self, v):
        return self.sqr_norm() >= v.sqr_norm()

    #########################
    # ASSIGNMENT OPERATIONS #
    #########################

    def __ladd__(self, v):
        return self + v

    def __lsub__(self, v):
        return self - v
    
    def __lmul__(self, a):
        return self * a
    
    def __ldiv__(self, a):
        return self / a
    
    def __lpow(self, a, b):
        return self ** a

    ###################
    # OTHER FUNCTIONS #
    ###################

    cpdef double dot(self, vec3 v):
        return self.x*v.x + self.y*v.y + self.z*v.z

    cpdef vec3 cross(self, vec3 v):
        return vec3(self.y*v.z - self.z*v.y,
                    self.z*v.x - self.x*v.z,
                    self.x*v.y - self.y*v.x)

    cpdef double norm(self):
        return sqrt(self.dot(self))

    cpdef double sqr_norm(self):
        return self.dot(self)

    cpdef vec3 normalize(self):
        # If self.norm == 0 returns original vec3
        return self / self.norm()


# Standard basis vectors
cdef vec3 e1 = vec3(1,0,0)
cdef vec3 e2 = vec3(0,1,0)
cdef vec3 e3 = vec3(0,0,1)
cdef vec3 i_hat = e1
cdef vec3 j_hat = e2
cdef vec3 k_hat = e3
