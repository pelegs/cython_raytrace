#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3

cdef class Ray:
    """
    A ray to be traced.
    """
    def __init__(self, pos, dir):
        self.pos = pos
        self.dir = dir.normalize()

    cpdef vec3 point_at_param(self, double t):
        return self.pos + t * self.dir

    cpdef double hit_sphere(self, sphere):
        cdef double r = sphere.rad
        cdef vec3 C = sphere.center
        cdef vec3 A = self.pos
        cdef vec3 B = self.dir
        cdef double a = B.sqr_norm()
        cdef double b = 2*B.dot(A-C)
        cdef double c = (A-C).sqr_norm() - r**2
        cdef double discr = b**2 - 4*a*c
        if discr < 0.0:
            return -1.0
        else:
            return (b + sqrt(discr))/(2.*a)
    
    cpdef vec3 sphere_color(self, sphere):
        cdef double t = self.hit_sphere(sphere)
        if t > 0.0:
            return (self.point_at_param(t) - sphere.center).normalize()
        else:
            return origVec
