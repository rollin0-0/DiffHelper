# -*- coding:utf-8 -*-

import os
import platform
import re
import sys
from distutils.version import StrictVersion


def colorPrint(log, color="31"):
    print("\033[0;%s;m%s\033[0m" % (color, log))


# 判断当前运行操作系统
if platform.system() != "Darwin":
    colorPrint("请在Mac OS操作系统运行该工具")
    os._exit(1)

parPath = os.path.dirname(os.path.abspath(__file__))
if " " in parPath:
    colorPrint(parPath)
    colorPrint("工具所在的路径包含了空格,请移除路径中的空格后重试")
    os._exit(1)

# 需要安装的依赖以及对应的版本
kRequiredLib = {
    "biplist": "1.0.2",
    "filetype": "1.0.5",
    "lxml": "4.4.2",
    "nltk": "3.4.5",
    "pyDes": "2.0.1",
    "Pillow": "6.1.0",
    "requests": "2.21.0",
}


# 获取当前系统版本
def curSystemVersion():
    output = os.popen("sw_vers | awk 'NR==2 {print $2}'")
    lines = output.readlines()
    output.close()
    systemVersion = lines[0].strip()
    print("MacOS: " + systemVersion)
    if StrictVersion(systemVersion) >= StrictVersion("10.15"):
        output = os.popen("spctl --status | awk 'NR==1 {print $2}'")
        status = output.readline()
        output.close()
        if status.strip() == "disabled":
            return
        colorPrint("10.15系统开始,使用本工具需要关闭spctl", "33")
        colorPrint("请在终端执行以下命令来关闭spctl:", "33")
        print("sudo spctl --master-disable")
        colorPrint("因为涉及到sudo,本工具不提供自动执行操作,建议自行了解以上命令后决定")
        colorPrint('执行完成后需要设置: 系统偏好设置 -> 安全性与隐私 -> 通用 -> 选择"任何来源"')
        colorPrint("设置之后重新运行当前脚本即可")
        os._exit(1)


# 判断当前运行python环境
def curPythonVersion():
    print("Python: %s" % (platform.python_version()))
    if platform.python_version() != "3.7.3":
        colorPrint("请确认在python3.7.3环境运行该工具,其他版本确认不能正常运行")
        colorPrint("详情见:", "32")
        colorPrint("https://github.com/iOSCoda/DiffHelper/wiki/Python环境安装", "33")
        os._exit(1)


# pip3版本
def curPip():
    output = os.popen("pip3 -V")
    lines = output.readlines()
    output.close()
    if len(lines) == 0:
        colorPrint("本工具依赖pip3,检测到未安装pip3模块", "33")
        colorPrint("请在终端执行以下命令来安装pip3:", "33")
        print("sudo easy_install pip3")
        colorPrint("因为涉及到sudo,本工具不提供自动执行操作,建议自行了解以上命令后决定")
        colorPrint("执行完成后重新运行当前脚本即可")
        os._exit(1)
    else:
        outputString = lines[0]
        resultList = re.findall(r"\((.*?)\)", outputString)
        if len(resultList) == 0:
            colorPrint("本工具依赖pip3,检测到未安装pip3模块", "33")
            colorPrint("请在终端执行以下命令来安装pip3:", "33")
            print("sudo easy_install pip3")
            colorPrint("因为涉及到sudo,本工具不提供自动执行操作,建议自行了解以上命令后决定")
            colorPrint("执行完成后重新运行当前脚本即可")
            os._exit(1)
        else:
            curPipViersion = resultList[0]
            if curPipViersion == "python 3.7":
                print("Pip3: " + curPipViersion)
            else:
                colorPrint("本工具依赖pip3,检测到未安装pip3模块", "33")
                colorPrint("请在终端执行以下命令来安装pip3:", "33")
                print("sudo easy_install pip3")
                colorPrint("因为涉及到sudo,本工具不提供自动执行操作,建议自行了解以上命令后决定")
                colorPrint("执行完成后重新运行当前脚本即可")
                os._exit(1)


# 当前Xcode版本信息
def checkXcodeInstalled():
    output = os.popen("/usr/bin/xcodebuild -version")
    lines = output.readlines()
    output.close()
    if not lines:
        colorPrint("请确认已经安装Xcode")
        os._exit(1)
    print(lines[0].strip())


# 判断是否安装xcode-select
def checkXcodeSelect():
    output = os.popen("xcode-select -p")
    content = output.readline()
    output.close()
    if not content:
        colorPrint("当前未安装xcode-select,现在开始安装:", "33")
        os.system("xcode-select --install")
    elif "Xcode.app/Contents/Developer" not in content.strip():
        colorPrint("工具会使用到脚本打包项目的功能,需要设置xcode-select对应的位置", "33")
        colorPrint("请在终端执行以下命令完成设置:", "33")
        print("sudo xcode-select -s %s" % (content.strip()))
        colorPrint("因为涉及到sudo,本工具不提供自动执行操作,建议自行了解以上命令后决定")
        colorPrint("执行完成后重新运行当前脚本即可")
        os._exit(1)


# 获取当前pip3 list
def getPip3List():
    output = os.popen("pip3 list")
    lines = output.readlines()
    output.close()
    if not lines:
        colorPrint("检测到未安装pip3模块,请重新运行当前脚本")
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
    print("")
    print("*" * 32 + "开始检测运行环境" + "*" * 32)
    curSystemVersion()
    curPythonVersion()
    curPip()
    checkXcodeInstalled()
    checkXcodeSelect()
    time = 1
    colorPrint("Pip提示更新的警告可以忽略", "32")
    while not operateEnvOK():
        if time == 1:
            colorPrint("首次运行将自动安装工具依赖库", "33")
        if time > 3:
            colorPrint("多次安装依赖库失败,请确认网络连接,重启终端重试")
            colorPrint("或者尝试手动安装依赖,所有依赖库在上面的第26行代码里")
            colorPrint("\t例如安装biplist,命令如下:")
            colorPrint("\tpip3 install biplist==1.0.2")
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
except:
    colorPrint("解决方案1:\n\t初次完成依赖安装请重启终端再次运行")
    colorPrint("解决方案2:\n\t输入python3,输入空格,将start.py文件拖到空格后面,输入回车")

if __name__ == "__main__":
    JustDoIT.justDoIT()
