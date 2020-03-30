
<div align=center>
<img src="https://i.loli.net/2020/02/28/H5ukD27Wa1olx4h.png" width = "100" height = "100"/>
</div>

## 信息收集

该工具在使用的时候,总共会发出4个网络请求
```
1.获取网络时间(域名是baidu.com,鉴权)
2.鉴定网络时间(域名是yq.aliyun.com,鉴权)
3.日志收集(工具启动上报)
4.日志收集(工具成功上报)
```
**一旦使用本工具代表允许以上信息的收集**

**除以上信息收集之外,一旦发现其他请求,送VIP使用时间半年**


## 版本:
最新版本: **1.4.2(2020-03-30)**

### 更新日志:
```
有效期到2020年4月中
1.修复了特大项目会出现 “混淆出错的问题”
2.增加了部分敏感词库
如果试用版使用过程中遇到问题，欢迎联系开发者
```

详情请见 [更新日志](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/更新日志)

# 介绍

## DiffHelper
iOS代码差异化工具，它是针对现有iOS项目代码进行差异化的工具，开发者一直在使用和开发中

**您的star是我更新最大的动力**

**符号(symbol)**
```
iOS项目中 类、分类、协议、方法、属性、宏、静态变量、静态常量、block、枚举等等的统称
iPA安装包中的二进制(可执行)文件能找到以上所有的符号,所以他们是需要被修改的
```

## 优势
1. 处理后的符号(符号的概念见上面的术语解释)更加接近开发人员的命名习惯,处理后的代码可阅读性高(没有使用随机的单词组合),这也是过机审的关键
2. 支持OC所有的语法
3. 所涉及到的文件名同步修改
4. 支持当前主流的资源类型差异化处理(修改名字,修改文件md5)
5. 支持多种白名单
6. 其实1才是优势(也是绝对的优势)

## 功能介绍图「此处有张图片」
![desc.png](https://i.loli.net/2020/03/29/WwfGeCxLoKNiIp8.png)

## 备份下载地址:

如果github下载慢可以去码云下载
版本:`1.4.2(2020-03-30)` 已同步更新
```
https://gitee.com/halocode/DiffHelper
```


## 1. 运行环境:

```
MacOS系统 Python3.7.3版本(工具下有python-3.7.3安装包--python-3.7.3-macosx10.9.pkg)
```

## 2. 支持混淆的语言

```
Objective-C(不支持Swift)
```

## 3. 关于试用版

```
1. 直接下载即为试用版(试用版会一直提供)
2. 试用版会随机混淆50%左右的代码
3. 随机不混淆的50%部分只会在原符号基础上前后添加字母(这是试用版的限制)
4. 试用版增加了限制机制，多次混淆不会增加混淆比例
```

**示例：**
```
- (void)hello;//原方法

如果在混淆的50%里:
- (void)xxx;//混淆结果未知

如果在不混淆的50%里:
- (void)aHelloa;//大概是这样，只会有前后随机字母的差别
```


## 4. 关于VIP版

```
VIP版本100%混淆
如需VIP版本，请联系开发者(QQ: 2108336019)
```


### VIP版本效果展示

**混淆示例:**
```
类名 AFNetworkActivityIndicatorManager 修改为: OutMeshingInactivityIndicantManager
类名 CocoaSecurityResult 修改为: HotChocolateSuretyResult
属性 networkActivityActionBlock 修改为: meshActionActivenessBlock
属性 verCodeBtn 修改为: forwardCodeSelection
方法 screenShotWithName 修改为: blindJibeSetName
方法 forgetPasswordController 修改为: blockWatchwordController
资源:png titleHelper 修改为: claimHelper
资源:xib LowlyController 修改为: HumbleController
xcassets IQKeyboardManager 修改为: CaptionParentalManager
define StrongObject 修改为: StrongTarget
static tupe 修改为: variance
protocol Optional 修改为: Several
...
```


## 5. 功能和使用

* [功能介绍](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/功能介绍)

* [Python环境安装](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/Python环境安装)

* [配置文件详解](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/配置文件详解)

* [使用说明](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/使用说明)

* [常见错误](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/常见错误)


## 个人公众号
> 公众号会分享一些App Store过审相关的思路、技术、总结，欢迎联系，感谢关注

![QRCode.png](https://i.loli.net/2020/02/08/Zdhmz9ot8N5Hw3c.png)




