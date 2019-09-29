# -*- coding:utf-8 -*-

import os
import sys
import platform
from distutils.version import StrictVersion

# 判断当前运行操作系统
if platform.system() != "Darwin":
    print("请在Mac OS操作系统运行该工具")
    os._exit(1)

# 路径空格判断
if " " in os.getcwd():
    print(os.getcwd())
    print("工具所在的路径包含了空格,请移除路径中的空格后重试")
    os._exit(1)

# 需要安装的依赖以及对应的版本
kRequiredLib = {
    "pbxproj": "2.5.1",
    "nltk": "3.4.5",
    "ntplib": "0.3.3",
    "requests": "2.21.0",
    "PyYAML": "5.1.2",
    "pyDes": "2.0.1",
    "biplist": "1.0.2"
}


# 判断当前是否存在pip3
def pip3Check():
    output = os.popen("pip3 list")
    lines = output.readlines()
    output.close()
    if len(lines) == 0:
        print('检测到未安装pip3模块,现在开始安装......')
        os.system("sudo easy_install pip3")
        return None
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
    os.system("pip3 install %s==%s" % (lib, requiredVersion))


def operateEnvOK():
    installedDict = getInstalledLib()
    for lib in kRequiredLib:
        requiredVersion = kRequiredLib[lib]
        if lib in installedDict:
            curVersion = installedDict[lib]
            if StrictVersion(curVersion) < StrictVersion(requiredVersion):
                installLib(lib, requiredVersion)
        else:
            installLib(lib, requiredVersion)

    allInstalled = True
    installedDict = getInstalledLib()
    for lib in kRequiredLib:
        if lib not in installedDict:
            allInstalled = False
    return allInstalled


# 判断当前运行python环境
def curPythonVersion():
    print("Python: %s" % (platform.python_version()))
    if sys.version_info[0] < 3:
        print("请确认在python3环境运行该工具")
        print("或者安装工具文件夹下的python-3.7.3-macosx10.9.pkg")
        os._exit(1)


# 当前xcode版本信息
def checkXcodeInstalled():
    output = os.popen("/usr/bin/xcodebuild -version")
    lines = output.readlines()
    output.close()
    for line in lines:
        print(line.strip())


# 判断是否安装xcode-select
def xcodeSelect():
    output = os.popen(
        "if xcode-select -p &>/dev/null; then echo 'installed'; else echo 'notInstall'; fi"
    )
    content = output.readline()
    output.close()
    if content == "notInstall":
        print("当前未安装xcode-select,现在开始安装:")
        os.system("xcode-select --install")


def checkOperateEnv():
    print("*" * 32 + "开始检测运行环境" + "*" * 32)
    curPythonVersion()
    checkXcodeInstalled()
    xcodeSelect()
    time = 1
    while not operateEnvOK():
        if time > 3:
            print("多次安装依赖库失败,请确认网络连接,重启终端重试")
            os._exit(1)
        else:
            print("\n运行环境不符合要求,正在安装依赖[%d]" % (time))
            operateEnvOK()
            time += 1
    print("*" * 32 + "运行环境符合要求" + "*" * 32)


checkOperateEnv()

toolPath = os.path.join(os.getcwd(), "Tool")
sys.path.append(toolPath)

try:
    import JustDoIT
except Exception as exception:
    print("请打开终端,输入cd,输入空格,将iOSCodeDifferHelper文件夹拖到空格后面,输入回车")
    print("输入python3 start.py,输入回车")

if __name__ == "__main__":
    JustDoIT.justDoIT()
