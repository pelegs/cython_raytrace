from vec3 cimport *

cdef class Camera:
    cdef vec3 origin
    cdef vec3 dir
    cdef vec3 vertical
    cdef vec3 horizontal
    cdef vec3 screen_size
    cdef double field_of_view
    cdef double aperture
    cdef double focal_length
    cdef vec3 lower_left_corner
