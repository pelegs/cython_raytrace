from vec3 cimport *
import numpy as np
cimport numpy as np
#cython: boundscheck=False, wraparound=False, nonecheck=False, language_level=3

cdef class Camera:
    def __init__(self, origin=origVec, dir=-zhat,
                 vertical=yhat, screen_size=vec3(400,400,0),
                 field_of_view=90, aperture=0, focal_length=1):
        self.origin = origin
        self.dir = dir.normalize()
        self.vertical = vertical
        self.horizontal = dir.cross(vertical)
        self.screen_size = screen_size
        self.field_of_view = field_of_view
        self.aperture = aperture
        self.focal_length = focal_length
        self.lower_left_corner = self.origin - self.horizontal/2 - self.vertical/2 + self.dir*self.focal_length
        print(self.lower_left_corner)
