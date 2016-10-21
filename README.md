<h1 align="center">
ZYSideSlipFilter
<h5 align="center", style="color, #666">
side slip filter with your goods page, support custom action, support custom region, custom all the things.   
<br>
侧边栏条件筛选器，支持自定义事件，自定义筛选栏目，自定义所有。。。  
</h5>
</h1>

<br>
<br>
![](https://raw.githubusercontent.com/liuzhiyi1992/MyStore/master/ZYSideSlipFilter/SideSlipFilter%E7%BB%93%E6%9E%84%E7%A4%BA%E6%84%8F%E5%9B%BEedge.jpg)


#**Usage：**  
创建ZYSideSlipFilterController实例，让呼出者controller持有它，这样我们能够保持着Filter的状态并且能够多次呼出(我们要求呼出者必须有navigationController)  
```objc
self.filterController = [[ZYSideSlipFilterController alloc] initWithSponsor:self 
                                                                 resetBlock:^(NSArray *dataList) {
    //Reset Data
}                                                               commitBlock:^(NSArray *dataList) {
    //Commit Data
}];
_filterController.animationDuration = .3f;
_filterController.sideSlipLeading = 0.15*[UIScreen mainScreen].bounds.size.width;
_filterController.dataList = [self packageDataList];
```

就是这样，我们的filter可以投向使用了吗？并不是，最重要的是我们的数据源dataList。数据源的结构见数据源结构图，ZYSideSlipFilter会按照数据源结构规则去工作起来。  

数据源准备好后, 让Filter显示出来
```objc
[_filterController show];
```

![](https://raw.githubusercontent.com/liuzhiyi1992/MyStore/master/ZYSideSlipFilter/ZYSideSlipFilterModel%E7%BB%93%E6%9E%84%E5%9B%BE%E6%88%AA%E5%9B%BE.png)  

