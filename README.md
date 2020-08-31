<div align=center>
<img src="https://i.loli.net/2020/02/28/H5ukD27Wa1olx4h.png" width = "100" height = "100"/>
</div>

## [信息收集说明](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/信息收集说明)

## 版本: **1.6.3(2020-08-31)**

### 更新日志:

```
试用版有效期到9月下旬
配置文件修改为json类型
人工干预模式增加了选词功能
```

[配置文件详解](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/配置文件详解)

详情请见 [更新日志](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/更新日志)

### 温馨提示:

> 如果按照最下面的使用文档，期间遇到错误，麻烦先移步到 [常见错误](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/常见错误)
>
> 如果是这之外的错误，那么肯定是我兼容性做的还不够好，希望你能联系我

## 备份下载地址 1: [微云下载](https://share.weiyun.com/uQFXsJxe)

## 备份下载地址 2: [码云下载](https://gitee.com/halocode/DiffHelper)

# 介绍

## DiffHelper

> iOS 代码差异化工具，它是针对现有 iOS 项目代码进行差异化的工具，开发者一直在使用和开发中

### 您的 star 是我更新最大的动力

**符号(symbol)**

```
iOS项目中 类、分类、协议、方法、属性、宏、静态变量、静态常量、block、枚举等等的统称
iPA安装包中的二进制(可执行)文件能找到以上所有的符号，所以他们是需要被修改的
```

## 优势

1. 处理后的符号(符号的概念见上面的术语解释)更加接近开发人员的命名习惯，处理后的代码可阅读性高(没有使用随机的单词组合)，这也是过机审的关键
2. 支持 OC 所有的语法
3. 所涉及到的文件名同步修改
4. 支持几乎所有主流的资源类型(修改名字，修改文件 md5)
5. 支持多种白名单
6. 其实 1 才是优势(也是绝对的优势)

## 功能介绍图「此处有张图片」

![desc.png](https://i.loli.net/2020/03/29/WwfGeCxLoKNiIp8.png)

## 1. 运行环境:

> MacOS 系统 Python3.7.3 版本 [Python 环境安装](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/Python环境安装)

## 2. 支持混淆的语言

> Objective-C(不支持 Swift)

## 3. 关于试用版

> 1. 直接下载即为试用版(试用版会一直提供)
> 2. 试用版会随机混淆 30%左右的代码
> 3. 随机不混淆的 70%部分只会在原符号基础上前后添加字母(这是试用版的限制)
> 4. 试用版增加了限制机制，多次混淆不会增加混淆比例

**示例：**

> +(void)hello; //原方法

**如果在混淆的 30%里:**

> +(void)xxx; //混淆结果未知

**如果在不混淆的 70%里:**

> +(void)aHelloa; //大概是这样，只会有前后随机字母的差别

## 4. 关于 VIP 版

```
VIP版本100%混淆
如需VIP版本，请联系开发者(QQ: 2108336019)
```

### VIP 版本效果展示

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

- [功能介绍](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/功能介绍)

- [混淆前后注意事宜和建议](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/混淆前后注意事宜和建议)

- [Python 环境安装](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/Python环境安装)

- [配置文件详解](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/配置文件详解)

- [使用说明](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/使用说明)

- [常见错误](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/常见错误)

## 个人公众号

> 公众号会分享一些 App Store 过审相关的经验、思路、技术、总结，欢迎联系，感谢关注

![QRCode.png](https://i.loli.net/2020/02/08/Zdhmz9ot8N5Hw3c.png)
