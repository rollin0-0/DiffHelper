存在的bug麻烦提issue,所有的bug我都抽时间修复的,越详细的issue,能越定位问题和修复,如果可以的话,直接丢相关的工程是坠吼滴

# 更新日期: 2019-06-04 

1.修复修改分类时出现的bug 感谢[Kuitous](https://github.com/Kuitous)提供的详细执行过程

2.demo更新为线上的一个开源项目

# iOSCodeDifferHelper
代码差异化助手(比手还快)

## 该版本会随机差异化一半的符号，符号的概念请参考[Wiki](https://github.com/rowliny/iOSCodeDifferHelper/wiki)

## 支持运行环境:

```
MacOS
Python 3.7
```

## 支持语言

```
Objective-C (不支持Swift)
```

# 功能

```
0.支持备份源码
1.支持类名修改(支持分类)，对应的文件名同步修改
2.支持方法名修改
3.支持属性修改
4.支持文件夹修改
5.支持类白名单设置
    5.0 自动不修改系统类
    5.1 支持设置不需要修改的类
    5.2 支持设置不需要修改的文件夹里的类
    5.3 支持设置不修改某些类的属性(适用于model类)
6.支持设置不需要修改的方法
    6.0 自动不修改系统方法
7.支持设置不需要修改的属性
    7.0 自动不修改系统属性
8.支持自定义类、方法、属性前缀
9.支持 protocol、block、define、枚举、静态变量 修改
10.支持修改资源文件
    9.0 支持png,jpg文件
    9.1 支持bundle,plist文件
    9.2 支持mp3,wav文件
    9.3 xib、sb文件 xib、sb文件和对应的类同步修改
11.支持修改文件创建时间和修改时间
```

# 安装和使用说明
[点击前往Wiki](https://github.com/rowliny/iOSCodeDifferHelper/wiki)






