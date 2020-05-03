# -*- coding:utf-8 -*-

import os
import re
import platform
import sys
from distutils.version import StrictVersion

# 判断当前运行操作系统
if platform.system() != "Darwin":
    print("请在macOS操作系统运行该工具")
    os._exit(1)

parPath = os.path.dirname(os.path.abspath(__file__))
if " " in parPath:
    print(parPath)
    print("工具所在的路径包含了空格,请移除路径中的空格后重试")
    os._exit(1)

# 需要安装的依赖以及对应的版本
kRequiredLib = {
    "biplist": "1.0.2",
    "filetype": "1.0.5",
    "lxml": "4.4.2",
    "nltk": "3.4.5",
    "PyYAML": "5.1.2",
    "pyDes": "2.0.1",
    "Pillow": "6.1.0",
    "requests": "2.21.0",
}


# 获取当前系统版本
def curSystemVersion():
    output = os.popen("sw_vers | awk 'NR==2 {print $2}'")
    lines = output.readlines()
    output.close()
    print("MacOS: " + lines[0].strip())


# 判断当前运行python环境
def curPythonVersion():
    print("Python: %s" % (platform.python_version()))
    if platform.python_version() != "3.7.3":
        print("请确认在python3.7.3环境运行该工具")
        print("请查看wiki:")
        print("https://github.com/iOSCoda/DiffHelper/wiki/Python环境安装")
        os._exit(1)


# pip3版本
def curPip():
    output = os.popen("pip3 -V")
    lines = output.readlines()
    output.close()
    if len(lines) == 0:
        print("检测到未安装pip3模块,现在开始安装......")
        os.system("sudo easy_install pip3")
    else:
        outputString = lines[0]
        resultList = re.findall(r"\((.*?)\)", outputString)
        if len(resultList) == 0:
            print("检测到未安装pip3模块,现在开始安装......")
            os.system("sudo easy_install pip3")
        else:
            curPipViersion = resultList[0]
            if curPipViersion == "python 3.7":
                print("Pip3: " + curPipViersion)
            else:
                print("检测到未安装pip3模块,现在开始安装......")
                os.system("sudo easy_install pip3")



# 当前Xcode版本信息
def checkXcodeInstalled():
    output = os.popen("/usr/bin/xcodebuild -version")
    lines = output.readlines()
    output.close()
    if len(lines) == 0:
        print("请确认已经安装Xcode")
        os._exit(1)
    print(lines[0].strip())


# 判断是否安装xcode-select
def checkXcodeSelect():
    output = os.popen("if xcode-select -p &>/dev/null; then echo '1'; else echo '0'; fi")
    content = output.readline()
    output.close()
    if content == "0":
        print("当前未安装xcode-select,现在开始安装:")
        os.system("xcode-select --install")


# 获取当前pip3 list
def getPip3List():
    output = os.popen("pip3 list")
    lines = output.readlines()
    output.close()
    if len(lines) == 0:
        print("检测到未安装pip3模块,请重新运行当前脚本")
        os._exit(1)
    return lines


# 获取已经安装的依赖库
def getInstalledLib():
    lines = getPip3List()
    installedDict = {}
    for line in lines:
        line = line.strip()
        tmpList = line.split(" ")
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
            break
    return allInstalled


def checkOperateEnv():
    print("*" * 32 + "开始检测运行环境" + "*" * 32)
    curSystemVersion()
    curPythonVersion()
    curPip()
    checkXcodeInstalled()
    checkXcodeSelect()
    time = 1
    print("\033[0;33;m%s\033[0m" % ("Pip提示更新的警告可以忽略"))
    while not operateEnvOK():
        if time == 1:
            print("首次运行将自动安装工具依赖")
        if time > 3:
            print("多次安装依赖库失败,请确认网络连接,重启终端重试")
            print("或者尝试手动安装依赖,所有依赖库在上面的第21行代码里")
            print("\t例如安装biplist,命令如下:")
            print("\tpip3 install biplist==1.0.2")
            os._exit(1)
        else:
            print("\n运行环境不符合要求,正在安装依赖[%d]" % (time))
            operateEnvOK()
            time += 1
    print("*" * 32 + "运行环境符合要求" + "*" * 32)


checkOperateEnv()


toolPath = os.path.join(parPath, "Tool")
sys.path.append(toolPath)
os.chdir(parPath)

try:
    import JustDoIT
except Exception as exception:
    print("解决方案1:\n\t初次完成依赖安装请重启终端再次运行")
    print("解决方案2:\n\t查看以下链接中常见错误3")
    print("\thttps://github.com/iOSCoda/DiffHelper/wiki/常见错误")
    print("解决方案3:\n\t输入python3,输入空格,将start.py文件拖到空格后面,输入回车")

if __name__ == "__main__":
    JustDoIT.justDoIT()
