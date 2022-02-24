# -*- coding:utf-8 -*-
import os
import platform
import sys

parPath = os.path.dirname(os.path.abspath(__file__))

toolPath = os.path.join(parPath, "Tool")
sys.path.append(toolPath)

sitePath = os.path.join(toolPath, "SitePackages")
sys.path.append(sitePath)

from packaging import version


Red = "31"
Green = "32"
Yellow = "33"


def colorPrint(color, log):
    print("\033[0;%s;m%s\033[0m" % (color, log))


# 判断当前运行操作系统
if platform.system() != "Darwin":
    colorPrint(Red, "请在macOS操作系统运行该工具")
    os._exit(1)

if " " in parPath:
    colorPrint(Red, parPath)
    colorPrint(Red, "工具所在的路径包含了空格,请移除路径中的空格后重试")
    colorPrint(Yellow, "建议将工具直接放在桌面")
    os._exit(1)


# 获取当前系统版本
def curSystemVersion():
    output = os.popen("sw_vers | awk 'NR==2 {print $2}'")
    lines = output.readlines()
    output.close()
    systemVersion = lines[0].strip()
    colorPrint(Green, "macOS: " + systemVersion)
    if version.parse(systemVersion) >= version.parse("10.15"):
        output = os.popen("spctl --status | awk 'NR==1 {print $2}'")
        status = output.readline()
        output.close()
        if status.strip() == "disabled":
            return
        colorPrint(Yellow, "10.15系统开始,使用本工具需要关闭spctl")
        colorPrint(Yellow, "请在终端执行以下命令来关闭spctl:")
        colorPrint(Green, "sudo spctl --master-disable")
        colorPrint(Red, "因为涉及到sudo,本工具不提供自动执行操作,建议自行了解以上命令后决定")
        colorPrint(Red, '执行完成后需要设置: 系统偏好设置.app -> 安全性与隐私 -> 通用 -> 选择"任何来源"')
        colorPrint(Red, "设置之后重新运行当前脚本即可")
        os._exit(1)


# 判断当前SIP状态
def curSIPStatus():
    output = os.popen("sysctl -n machdep.cpu.brand_string")
    status = output.readline()
    if "Apple" not in status:
        return

    output = os.popen("csrutil status")
    status = output.readline()
    if "enabled" in status:
        colorPrint(Red, "m1芯片设备需要关闭SIP")
        colorPrint(Green, "详情见:")
        colorPrint(Yellow, "https://github.com/rowliny/DiffHelper/wiki/M1芯片关闭SIP")
        os._exit(1)


# 判断当前运行python环境
def curPythonVersion():
    colorPrint(Green, "Python: " + platform.python_version())
    if platform.python_version() != "3.10.0":
        colorPrint(Red, "请确认在python3.10.0环境运行该工具,其它版本确实不能运行")
        colorPrint(Green, "详情见:")
        colorPrint(Yellow, "https://github.com/rowliny/DiffHelper/wiki/Python环境安装")
        colorPrint(Yellow, "或者直接安装附带的python安装包:python-3.10.0post2-macos11.pkg")
        os._exit(1)


# 当前Xcode版本信息
def checkXcodeInstalled():
    output = os.popen("/usr/bin/xcodebuild -version")
    lines = output.readlines()
    output.close()
    if not lines:
        colorPrint(Red, "请确认已经安装Xcode")
        colorPrint(Yellow, "如果确认已经安装Xcode")
        colorPrint(Yellow, "请在终端执行以下命令完成设置:")
        colorPrint(Green, "xcode-select -s /Applications/Xcode.app/Contents/Developer")
        os._exit(1)
    colorPrint(Green, lines[0].strip())


# 判断是否安装xcode-select
def checkXcodeSelect():
    output = os.popen("xcode-select -p")
    content = output.readline()
    output.close()
    if not content:
        colorPrint(Yellow, "当前未安装xcode-select,现在开始安装:")
        os.system("xcode-select --install")
    elif "Xcode.app/Contents/Developer" not in content.strip():
        colorPrint(Yellow, "工具会使用到脚本打包项目的功能,需要设置xcode-select对应的位置")
        colorPrint(Yellow, "请在终端执行以下命令完成设置:")
        colorPrint(Green, "sudo xcode-select -s %s" % (content.strip()))
        colorPrint(Red, "因为涉及到sudo,本工具不提供自动执行操作,建议自行了解以上命令后决定")
        colorPrint(Red, "执行完成后重新运行当前脚本即可")
        os._exit(1)


def checkOperateEnv():
    print("")
    print("*" * 32 + "开始检测运行环境" + "*" * 32)
    curSystemVersion()
    curSIPStatus()
    curPythonVersion()
    checkXcodeInstalled()
    checkXcodeSelect()
    print("*" * 32 + "运行环境符合要求" + "*" * 32)


os.chdir(parPath)

if __name__ == "__main__":

    checkOperateEnv()
    try:
        import JustDoIT
    except Exception:
        colorPrint(Red, "解决方案:\n\t请参考同级目录下的「使用演示.gif」")
        colorPrint(Red, "解决方案:\n\t请参考同级目录下的「m1设置.png」")
    JustDoIT.justDoIT()
