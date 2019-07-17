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


# 需要安装的依赖以及对应的版本
needLib = {
	"nltk":"3.4.1",
	"ntplib":"0.3.3",
	"requests":"2.21.0",
	"PyYAML":"5.1",
}

# 获取已经安装的依赖库
def getInstalledLib():
	command = "pip3 list"
	output = os.popen(command)
	lines = output.readlines()

	installedDict = {}
	for line in lines:
		line = line.strip()
		tmpList = line.split(' ')
		tmpList = [item for item in tmpList if len(item) > 0]
		if len(tmpList) == 2:
			lib = tmpList[0]
			version = tmpList[1]
			installedDict[lib] = version
	return installedDict


def installLib(lib,needVersion):
	tip = '检测到未安装%s模块,现在开始安装......' %(lib)
	print(tip)
	command = "pip3 install %s==%s" %(lib,needVersion)
	os.system(command)


for lib in needLib:
	# 已经安装
	installedDict = getInstalledLib()
	if lib in installedDict:
		installedVersion = installedDict[lib]
		needVersion = needLib[lib]

		if installedVersion != needVersion:
			installLib(lib,needVersion)
		else:
			tip = '检测到已经安装%s模块' %(lib)
			print(tip)
	else:
		installLib(lib,needLib[lib])


allInstalled = True
installedDict = getInstalledLib()
for lib in needLib:
	if lib not in installedDict:
		allInstalled = False

if allInstalled == True:
	print("-------------------------------------依赖环境满足要求-------------------------------------")
	print("请切换到路径:iOSCodeDifferHelper \n执行python3 start.py即可开始")
else:
	print("安装失败,请重新运行该脚本")
