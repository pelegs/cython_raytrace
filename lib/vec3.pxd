cdef NUMBERS

cdef class vec3:
    cdef readonly double x
    cdef readonly double y
    cdef readonly double z

    cpdef vec3 neg(self)
    cpdef vec3 add(self, vec3 v)
    cpdef vec3 sub(self, vec3 v)
    cpdef vec3 mul(self, double a)
    cpdef vec3 div(self, double a)
    cpdef vec3 pow(self, double a)
    cpdef double dot(self, vec3 v)
    cpdef vec3 cross(self, vec3 v)
    cpdef double norm(self)
    cpdef double sqr_norm(self)
    cpdef vec3 normalize(self)


cdef vec3 origVec
cdef vec3 xhat
cdef vec3 yhat
cdef vec3 zhat
cdef vec3 ihat
cdef vec3 jhat
cdef vec3 khat
