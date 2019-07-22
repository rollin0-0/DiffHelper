# -*- coding:utf-8 -*-

import os
import sys
import platform

# 判断当前运行操作系统
if platform.system() != "Darwin":
    print("请在Mac OS操作系统运行该工具")
    os._exit(1)

# 判断当前运行python环境
if sys.version_info[0] < 3:
    print("请确认在python3环境运行该工具")
    os._exit(1)

if " " in os.getcwd():
    print(os.getcwd())
    print("工具所在的路径包含了空格,请移除路径中的空格后重试")
    os._exit(1)

# 需要安装的依赖以及对应的版本
kRequiredLib = {
    "nltk": "3.4.1",
    "ntplib": "0.3.3",
    "requests": "2.21.0",
    "PyYAML": "5.1",
    "pyDes": "2.0.1"
}


# 判断当前是否存在pip3
def pip3Check():
    command = "pip3 list"
    output = os.popen(command)
    lines = output.readlines()
    if len(lines) == 0:
        print('检测到未安装pip3模块,现在开始安装......')
        os.system("sudo easy_install pip3")
        return None
    else:
        return lines


# 获取已经安装的依赖库
def getInstalledLib():
    lines = pip3Check()
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


# 安装依赖库
def installLib(lib, requiredVersion):
    command = "pip3 install %s==%s" % (lib, requiredVersion)
    os.system(command)


def operateEnvOK():
    installedDict = getInstalledLib()
    for lib in kRequiredLib:
        requiredVersion = kRequiredLib[lib]
        if lib in installedDict:
            if installedDict[lib] != requiredVersion:
                installLib(lib, requiredVersion)
        else:
            installLib(lib, requiredVersion)

    allInstalled = True
    installedDict = getInstalledLib()
    for lib in kRequiredLib:
        if lib not in installedDict:
            allInstalled = False

    if allInstalled:
        return True
    else:
        return False


def checkOperateEnv():
    print("开始检测运行环境.")
    pip3Check()
    time = 1
    while not operateEnvOK():
        if time > 3:
            print("多次安装依赖库失败,请确认网络连接,重启终端重试")
            os._exit(1)
        else:
            print("\n运行环境不符合要求,正在安装工具依赖[%d]" %(time))
            operateEnvOK()
            time += 1
    print("-------------------------运行环境符合要求-------------------------")


checkOperateEnv()

utilPath = os.path.join(os.getcwd(), "Tool")
sys.path.append(utilPath)

try:
    import JustDoIT
except Exception as exception:
    print("请打开终端,输入cd,输入空格,将iOSCodeDifferHelper文件夹拖到cd后面,输入回车")
    print("输入python3 start.py,输入回车")

if __name__ == "__main__":
    JustDoIT.justDoIT()
