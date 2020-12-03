#!/usr/bin/env python3
# -*- coding: iso-8859-15 -*-

from distutils.core import setup
from Cython.Build import cythonize
import numpy as np

setup(
        ext_modules=cythonize(['vec3.pyx', 'ray.pyx', 'shapes.pyx']),
        include_dirs=[np.get_include()]
)
