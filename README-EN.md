<div align=center>
<img src="https://i.loli.net/2020/02/28/H5ukD27Wa1olx4h.png" width = "100" height = "100"/>
</div>


# Introduce

## DiffHelper

> iOS Code Differentiation tool, it is a tool for differentiation of existing iOS project code, developers have been using and developing

### Your star is my biggest motivation for updating

**Symbol**

```
The general term for classes, categories, protocols, methods, properties, macros, static variables, static constants, blocks, enumerations, etc. in iOS projects
The binary (executable) file in the iPA installation package can find all the above symbols, so they need to be modified
```

## Advantage

1. The processed symbols (see the explanation of the terms above for the concept of symbols) are closer to the developer’s naming habits, and the processed code is highly readable (no random word combinations are used), which is also the key to machine review
2. Support all OC syntax
3. Synchronous modification of the file name involved
4. Support almost all mainstream resource types (modify name, modify file md5)
5. Support multiple whitelists
6. In fact, 1 is the advantage (also an absolute advantage)

## Function introduction diagram

![desc.png](https://i.loli.net/2020/03/29/WwfGeCxLoKNiIp8.png)

## 1. Operate Environment:

> MacOS  Python3.7.3

## 2. Support language

> Objective-C(Swift not yet)

## 3. About the trial version

> 1. Direct download is the trial version (the trial version will always be provided)
> 2. The trial version will randomly obfuscate about 30% of the code
> 3. The 70% part that is not randomly confused will only add letters before and after the original symbol (this is a limitation of the trial version)
> 4. The trial version adds a restriction mechanism, and multiple confusions will not increase the confusion ratio

**Example：**

> +(void)hello; //original method

**If in the 30% of confusion:**

> +(void)xxx; //Unknown result of confusion

**If in the 70% that is not confused:**

> +(void)aHelloa; //Probably so, there will only be the difference between the random letters before and after

## 4. About VIP Version

```
The VIP version is 100% confused
For VIP version, please contact the developer
```

### VIP version confuse display

**Example：:**

```
className AFNetworkActivityIndicatorManager -> OutMeshingInactivityIndicantManager
className CocoaSecurityResult -> HotChocolateSuretyResult
attribute networkActivityActionBlock -> meshActionActivenessBlock
attribute verCodeBtn -> forwardCodeSelection
method screenShotWithName -> blindJibeSetName
method forgetPasswordController -> blockWatchwordController
resource:png titleHelper -> claimHelper
resource:xib LowlyController -> HumbleController
xcassets IQKeyboardManager -> CaptionParentalManager
define StrongObject -> StrongTarget
static tupe -> variance
protocol Optional -> Several
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
