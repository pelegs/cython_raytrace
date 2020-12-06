#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3

"""
Defines 3-vectors and their operations
"""

cdef class vec3:
    """
    A 3-vector with real x, y, z components
    """
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

    def __getitem__(self, key):
        return [self.x, self.y, self.z][key]

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

    def to_tuple(self):
        return (int(self.x), int(self.y), int(self.z))

#####################
# CREATE FROM NUMPY #
#####################

cdef vec3 c_vec_from_np(np.ndarray[double, ndim=1] arr):
    return vec3(arr[0], arr[1], arr[2])

#####################
# IMPORTANT VECTORS #
#####################

# Zero vector
cdef vec3 origVec = vec3(0,0,0)
orig = origVec

# Unit vectors
cdef vec3 xhat = vec3(1,0,0)
cdef vec3 yhat = vec3(0,1,0)
cdef vec3 zhat = vec3(0,0,1)
cdef vec3 ihat = xhat
cdef vec3 jhat = yhat
cdef vec3 khat = zhat
x_ = xhat
y_ = yhat
z_ = zhat
i_ = ihat
j_ = jhat
k_ = khat
