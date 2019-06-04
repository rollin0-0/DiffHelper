# -*- coding:utf-8 -*-

import os
import sys

if " " in os.getcwd():
	print(os.getcwd())
	print("工具所在的位置包含了空格,当前版本暂不支持,请移除路径中的空格后重试")
	os._exit(1)

utilPath = os.path.join(os.getcwd(),"Tool")
sys.path.append(utilPath)

try:
	import JustDoIT
except Exception as e:
	print("打开终端,输入cd,输入空格,将下载的iOSCodeDifferHelper文件夹拖到cd后面,输入回车")
	print("输入python3 start.py,输入回车")
	print("如果还有问题,请发issue,工作日当天会回复的")

if __name__ == "__main__":
	JustDoIT.justDoIT()