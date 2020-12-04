#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3

"""
Defines relevant 3x3 matrices
"""

cdef class Matrix33:
    def __init__(self, c1, c2, c3):
        self.c1 = c1
        self.c2 = c2
        self.c3 = c3

    def __str__(self):
        # Print the vector to stdout
        return '({}\n {}\n {})'.format(self.c1,
                                     self.c2,
                                     self.c3)
    
    ####################
    # UNARY OPERATIONS #
    ####################
    
    def __pos__(self):
        return self
    """
    def __neg__(self):
        return self.neg()

    cpdef Matrix33 neg(self):
        return -1*self
    """
    #####################
    # BINARY OPERATIONS #
    #####################

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
        if type(self) in NUMBERS:
            return a.mul_scalar(self) 
        if type(a) == Matrix33:
            return self.dot_mat(a)
        elif type(a) == vec3:
            return self.dot_vec(a)
        elif type(a) in NUMBERS:
            return self.mul_scalar(a)

    # NOTE: write correct multiplication funcs
    # for int, float, double, etc. in one (via
    # multi def or whatever it's called).

    cpdef vec3 dot_vec(self, vec3 v):
        return vec3(self.c1.dot(v), self.c2.dot(v), self.c3.dot(v))

    cpdef Matrix33 dot_mat(self, Matrix33 m):
        return Matrix33(self.dot_vec(m.c1), self.dot_vec(m.c2), self.dot_vec(m.c3))


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

def rotate_mat(x=0, y=0, z=0):
    return rotate_x(x) * rotate_y(y) * rotate_z(z)
