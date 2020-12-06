from vec3 cimport *
from ray cimport Ray
import numpy as np
cimport numpy as np
from vec3 cimport *

cdef class Camera:
    cdef public vec3 pos
    cdef public vec3 dir
    cdef public vec3 vertical
    cdef public vec3 horizontal
    cdef public int[2] screen_size
    cdef public double aspect_ratio
    cdef public double pixel_size
    cdef public double field_of_view
    cdef public double aperture
    cdef public double focal_length
    cdef public vec3 upper_left_corner
    cdef public long[:, :, :] image

    cpdef Ray get_ray(self, int px, int px)
