from .image import mat_to_img
from .vec3 import *
from .matrix33 import *
from .ray import Ray
import numpy as np

class Camera:
    def __init__(self, pos=orig, dir=-z_,
                 vertical=y_, screen_size=(400,400),
                 field_of_view=90, aperture=0, focal_length=1):
        self.pos = pos
        self.dir = dir.normalize()
        self.vertical = vertical
        self.horizontal = dir.cross(vertical)
        self.screen_size = screen_size
        self.aspect_ratio = screen_size[1]/screen_size[0]
        self.pixel_size = 1./screen_size[1]
        self.field_of_view = field_of_view
        self.aperture = aperture
        self.focal_length = focal_length
        self.upper_left_corner = self.pos - self.horizontal/2 + self.vertical/2 + self.dir*self.focal_length
        self.image = np.zeros(shape=tuple(self.screen_size) + (3,), dtype=int)

    def get_ray(self, px, py):
        pixel = self.upper_left_corner + (px*self.horizontal - py*self.vertical) * self.pixel_size
        dir = pixel - self.pos
        return Ray(self.pos, dir)

    def rotate(self, axis=0, a=0.):
        if axis == 0:
            R = rotate_x(a)
        elif axis == 1:
            R = rotate_y(a)
        elif axis == 2:
            R = rotate_z(a)
        else:
            raise ValueError('Axis must be 0, 1 or 2')
        self.dir = R * self.dir
        self.horizontal = R * self.horizontal
        self.vertical = R * self.vertical
        self.upper_left_corner = R * self.upper_left_corner

    def move(self, dr):
        self.pos = self.pos + dr
        self.upper_left_corner = self.pos - self.horizontal/2 + self.vertical/2 + self.dir*self.focal_length

    def reset_image(self):
        self.image = np.zeros(shape=tuple(self.screen_size) + (3,), dtype=int)

    def test_render(self, sphere):
        self.reset_image()
        for i in range(self.screen_size[0]):
            for j in range(self.screen_size[1]):
                ray = self.get_ray(i, j)
                if ray.hit_sphere(sphere) > 0.:
                    uvw = sphere.uvw_image(ray.dir)
                    self.image[i,j,0] = uvw[0]
                    self.image[i,j,1] = uvw[1]
                    self.image[i,j,2] = uvw[2]
                else:
                    self.image[i,j] = [0,0,0]

    def save_img(self, filename='out.png'):
        mat_to_img(self.image, filename)
