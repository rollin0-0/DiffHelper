
<div align=center>
<img src="https://i.loli.net/2020/02/28/H5ukD27Wa1olx4h.png" width = "100" height = "100"/>
</div>

# DifferHelper
iOS代码差异化工具，顾名思义，它是针对现有iOS代码进行差异化的工具，开发者一直在使用和开发中

> 您的star是我更新最大的动力

**符号(symbol)**

```
iOS项目中 类、分类、协议、方法、属性、宏、静态变量、静态常量、block、枚举等等的统称
iPA安装包中的二进制(可执行)文件能找到以上所有的符号,所以他们是需要被修改的
```

## 优势
1. 处理后的符号(符号的概念见上面的术语解释)更加接近开发人员的命名习惯,处理后的代码可阅读性高(没有使用随机的单词组合),这也是过机审的关键
2. 支持OC所有的语法
3. 所涉及到的文件名同步修改
4. 支持当前主流的资源类型差异化(修改名字,修改文件md5)
5. 支持多种白名单
6. 其实1才是优势(也是绝对的优势)

## 功能介绍图「此处有张图片」
![desc.png](https://i.loli.net/2019/12/30/6A7N2nwa1HrpQP3.png)


## 更新:
最新版本: **1.3.8(2020-03-13)**

### 日志:
```
有效期到2020年3月底
1.优化了一些细节
2.混淆后直接打开项目即可
如果试用版使用过程中遇到问题，联系开发者有惊喜
```

详情请见 [更新日志](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/更新日志)


## 备份下载地址:

如果下载慢可以去码云下载

版本:`1.3.8(2020-03-13)` 已同步更新
```
https://gitee.com/halocode/DiffHelper
```


## 1. 运行环境:

```
MacOS系统 Python 3.7.3(工具文件夹下有python-3.7.3安装包「python-3.7.3-macosx10.9.pkg」)
```

## 2. 支持混淆的语言

```
Objective-C(不支持Swift)
```

## 3. 关于试用版

```
0. 直接下载即为试用版(试用版会一直提供)
1. 试用版会随机混淆50%左右的代码
2. 剩余50%部分只是简单的添加前后缀字母
3. 试用版增加了控制机制，多次混淆不会增加混淆比例
```

**例如：**
```
- (void)hello;//方法

如果在混淆的50%里:
- (void)xxx;//混淆结果未知

如果在不混淆的50%里:
- (void)BHelloB;//大概是这样，只会有前后随机字母的差别
```


## 4. 关于VIP版

```
VIP版本100%混淆
如需VIP版本，请联系开发者(QQ: 2108336019)
```


### VIP版本效果展示

**部分混淆示例:**
```
类名 ASNetworking 修改为: YawNetwork
类名 AttributeView 修改为: MulticastAttributeView
类名 AudioModel 修改为: AudioRoleModel
类名 BaseViewController 修改为: InfrastructureWatchController
类名 DDSoundWaveView 修改为: FreezingVocaliseUndulationView
类名 EttsModelTableViewCell 修改为: TaskPoseTabulariseViewCell
类名 EttsModelViewController 修改为: AvModelingViewController
类名 HeChengViewController 修改为: HeAmpersandPanoramaController
类名 InputTableViewCell 修改为: StimulationDeferHorizonCell
类名 ItemView 修改为: ItemSee
类名 MainTabBarController 修改为: PrincipalChitBarController
类名 NavigationTableViewCell 修改为: NavigationTabularizeViewCell
类名 QDAudioDataSource 修改为: MissingAudioRecordingDataSource
类名 QDDemoModel 修改为: SectorDemoModel
类名 QDPcmRecorder 修改为: SentencesTLGOTRecorder
类名 QDRealTimeRecognizeViewController 修改为: GeneratingSubstantialMetreRealizeWatch
类名 SelectionTableViewCell 修改为: ChoiceDeferSentimentCell
类名 SelectionTableViewController 修改为: NaturalSelectionRemitPositionController
类名 SliderTableViewCell 修改为: PseudemysScriptaHoldOverEyeshotCell
类名 SwitchTableViewCell 修改为: ChangeOverPostponeSightCell
类名 TTDFileReader 修改为: NecessaryChargeReader
类名 TTDFileWriter 修改为: ClustersFileWriter
类名 TTSConfigViewController 修改为: RetainPickerOpinionController
类名 XHToast 修改为: MenToast
类名 selectionCellContext 修改为: pickCellContext
...
```


## 5. 功能和使用

* [功能介绍](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/功能介绍)

* [安装](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/安装)

* [配置文件详解](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/配置文件详解)

* [使用说明](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/使用说明)

* [常见错误](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/常见错误)


## 个人公众号
> 公众号会分享一些App Store过审相关的思路、技术、总结，欢迎联系，感谢关注

![QRCode.png](https://i.loli.net/2020/02/08/Zdhmz9ot8N5Hw3c.png)




