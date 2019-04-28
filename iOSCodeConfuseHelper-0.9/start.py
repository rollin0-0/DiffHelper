# -*- coding:utf-8 -*-

import os
import sys


rootPath = os.getcwd()
utilPath = os.path.join(rootPath,"Tool")
sys.path.append(utilPath)

import JustDoIT

if __name__ == "__main__":

	JustDoIT.justDoIT()