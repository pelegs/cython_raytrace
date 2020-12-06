#!/usr/bin/env python3
# -*- coding: iso-8859-15 -*-

import numpy as np
import cv2

def mat_to_img(mat, filename='out.png'):
    cv2.imwrite(filename, np.array(mat))
