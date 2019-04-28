# iOSCodeConfuseHelper
代码混淆助手(比手还快)

针对马甲包
立场:

```
1.马甲包和第三方支付会破坏iOS生态
2.要恰饭的
```

# 功能

```
1.支持类名修改(支持分类)，对应的文件名同步修改
2.支持方法名修改
3.支持属性修改
4.支持静态变量修改
5.支持类白名单设置
    5.0 自动不修改系统类
    5.1 支持设置不需要修改的类
    5.2 支持设置不需要修改的文件夹里的类
    5.3 支持设置不修改某些类的属性(适用于model类)
6.支持设置不需要修改的方法
    6.0 自动不修改系统方法
7.支持设置不需要修改的属性
    7.0 自动不修改系统属性
8.支持自定义类前缀
9.支持修改资源文件
    9.0 支持png,jpg文件
    9.1 支持bundle,plist文件
```

## 支持运行环境:

```
MacOS
Python 3.7
```

## 支持语言

```
Objective-C (Swift没测过,不知道什么情况)
```

## 依赖环境配置:

## 安装python3
> brew install python

**检查python3安装情况**
> which python3

## 检查pip3安装情况
> which pip3

**找不到就安装:**
> python3 get-pip.py

## 安装yaml
> pip3 install PyYAML

## 安装requests
> pip3 install requests

## 安装NLTK
> pip3 install nltk



## 使用说明

## 配置文件:

**1.二进制文件放这里**
将源码编译出来的mach-o文件(编译出来的ipa包中的可执行文件)，复制到以下路径
> iOSCodeConfuseHelper/User/二进制文件放这里/

**2.源码放这里**
将需要混淆的源码，复制到以下路径
> iOSCodeConfuseHelper/User/源码放这里/

**3.配置文件修改:**
提供的是一个demo配置文件,建议复制一份自行修改使用
配置文件有说明
> iOSCodeConfuseHelper/User/UserConfig/UserConfig-Demo.yaml


## 运行:
### 切换到项目路径:
打开终端,输入cd空格,将iOSCodeConfuseHelper拖到cd后面，回车
例如:
> cd /Users/xxx/Desktop/iOSCodeConfuseHelper

### 运行脚本:
> python3 start.py





