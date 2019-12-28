该仓库会一直维护，开发者一直在使用和增加新功能

欢迎提建议和功能需求

您的star是我更新最大的动力

**公众号会分享一些过包相关的思路、技术、总结，欢迎关注**

![image](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/img/QRCode.png)

### 更新日期: 2019-12-02
```
有效期到2020年1月下旬
优化了混淆规则，生成的符号更加接近真人编写习惯
对于使用试用版多次混淆增加了限制(同一个符号多次被混淆后会越来越长)
```

2019-09-23

> 增加对于代码中@""字符串拆分处理

```
例如:
NSString *str = @"hello";
修改为
NSString *str = [@[@"h",@"e",@"l",@"l",@"o"] componentsJoinedByString:@""];
```


-------

### 0.前提 

```
0.该工具不会开源,介意勿下载
1.该工具能混淆OC开发的SDK/App
2.该工具不能混淆swift开发的SDK/App
3.该工具不能混淆unity/cocos的C++、C#代码
```



### 1.运行环境:

```
MacOS系统 Python 3.7
```



### 2.支持的开发语言

```
Objective-C (不支持Swift)
```


### 3.功能介绍图
![image](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/img/desc.png)


### 4.关于试用版

```
0.直接下载即为试用版
1.试用版会随机混淆30%左右的代码
2.剩余70%部分只是简单的添加前后缀字母
```

例如：
```
- (void)hello;//方法
```
如果被混淆:
```
- (void)xxx;//混淆结果未知
```

如果不混淆:
```
- (void)aHelloB;//大概是这样,只会有前后随机字母的差别
```


### 5.关于VIP版

```
如需VIP版本,请联系开发者
```


#### VIP版本效果展示

> 同一个demo项目两次混淆结果

![image](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/img/result_iOSTest-0918111304.png)

![image](https://github.com/iOSCoderMaster/iOSCodeDifferHelper/wiki/img/result_iOSTest-0918111430.png)






## 6.使用说明
[点击前往使用说明](https://github.com/rowliny/iOSCodeDifferHelper/wiki)






