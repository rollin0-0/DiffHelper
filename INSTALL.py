# -*- coding:utf-8 -*-

import sys
import os



# try:
# 	if sys.version_info[0] >= 3:
# 		import pip3
# 		print('检测到已经安装pip模块')
# except:
# 	print('检测到未安装pip模块,现在开始安装......')
# 	os.system("sudo easy_install pip3")
	

try:
	import nltk
	print('检测到已经安装nltk模块')
except:
	print('检测到未安装nltk模块,现在开始安装......')
	command = "pip3 install nltk"
	os.system(command)

try:
	import ntplib
	print('检测到已经安装ntplib模块')
except:
	print('检测到未安装ntplib模块,现在开始安装......')
	command = "pip3 install ntplib"
	os.system(command)

try:
	import requests
	print('检测到已经安装requests模块')
except:
	print('检测到未安装requests模块,现在开始安装......')
	os.system("pip3 install requests")

try:
	import PyYAML
	print('检测到已经安装PyYAML模块')
except:
	print('检测到未安装PyYAML模块,现在开始安装......')
	os.system("pip3 install PyYAML")

print("-------------------------------------依赖环境安装完成-------------------------------------")
print("请切换到路径:iOSCodeDifferHelper \n执行python3 start.py即可开始")
