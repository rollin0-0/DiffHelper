# -*- coding:utf-8 -*-

import os
import sys

utilPath = os.path.join(os.getcwd(),"Tool")
sys.path.append(utilPath)

import JustDoIT

if __name__ == "__main__":
	JustDoIT.justDoIT()