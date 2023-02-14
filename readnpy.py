# -*- coding: utf-8 -*-
"""
Created on Sat Dec 10 15:23:52 2022

@author: dekom
"""
import numpy as np

dx = np.load('dx.txt.npy')
dy = np.load('dy.txt.npy')
dz = np.load('dz.txt.npy')

dx = list(dx[0:1000])
dy = list(dy[0:1000])
dz = list(dz[0:1000])