# -*- coding:utf-8 -*-

import sys
import os



try:
	if sys.version_info[0] > 3:
		pipVersion = "pip3"
		import pip3
		print('检测到已经安装pip模块')
except:
	print('检测到未安装pip模块,现在开始安装......')
	command = "sudo easy_install pip"
	os.system(command)
	

try:
	import nltk
	print('检测到已经安装nltk模块')
except:
	print('检测到未安装nltk模块,现在开始安装......')
	command = pipVersion + " install nltk"
	os.system(command)

try:
	import ntplib
	print('检测到已经安装ntplib模块')
except:
	print('检测到未安装ntplib模块,现在开始安装......')
	command = pipVersion + " install ntplib"
	os.system(command)

try:
	import requests
	print('检测到已经安装requests模块')
except:
	print('检测到未安装requests模块,现在开始安装......')
	command = pipVersion + " install requests"
	os.system(command)

try:
	import PyYAML
	print('检测到已经安装PyYAML模块')
except:
	print('检测到未安装PyYAML模块,现在开始安装......')
	command = pipVersion + " install PyYAML"
	os.system(command)

print("-------------------------------------依赖环境安装完成-------------------------------------")
print("请切换到路径:iOSCodeDifferHelper \n执行python3 start.py即可开始")
