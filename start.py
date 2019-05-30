# -*- coding:utf-8 -*-

import os
import sys
import inspect

currentFilePath = inspect.getfile(inspect.currentframe())
currentDir = os.path.dirname(currentFilePath)
# /Users/rowling/iOSCodeConfuseHelper/iOSCodeConfuseHelper

utilPath = os.path.join(currentDir,"Tool")
sys.path.append(utilPath)

import JustDoIT

if __name__ == "__main__":
	JustDoIT.justDoIT()