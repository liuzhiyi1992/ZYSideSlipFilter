<h1 align="center">
ZYSideSlipFilter
<h5 align="center", style="color, #666">
side slip filter with your goods page, support custom action, custom region, custom all the things.   
<br>
侧边栏条件筛选器，支持自定义事件，自定义筛选栏目，自定义所有。。。样式完全自定义，ZYSideSlipFilter只负责给你工作     
</h5>
</h1>
<p align="center">
<img src="https://img.shields.io/badge/pod-v0.3.0-blue.svg" />
<img src="https://img.shields.io/badge/license-MIT-brightgreen.svg" />
</p>

<br>
![](https://raw.githubusercontent.com/liuzhiyi1992/MyStore/master/ZYSideSlipFilter/ZYSideSlipFilterGif.gif)
<br>
#CocoaPods  
```
pod 'ZYSideSlipFilter', '~> 0.3.0'
``` 

#Features  
[ZYSideSlipFilter](https://github.com/liuzhiyi1992/ZYSideSlipFilter)是一个侧边栏条件筛选器，功能当然就是那个，选择条件，保存选择状态，重置条件。即插即拔，基本支持自定义任何内脏，样式如何完全由你制定，Demo我做成了商城风格，其实怎样用全在于你自己。ZYSideSlipFilter的工作核心是数据源，它贯穿了整个工作流程。  

以下是Demo做出来的效果(样式仅供参考, 怎么定制全看个人喜好)，大致结构是这样的：
![](https://raw.githubusercontent.com/liuzhiyi1992/MyStore/master/ZYSideSlipFilter/SideSlipFilter%E7%BB%93%E6%9E%84%E7%A4%BA%E6%84%8F%E5%9B%BEedge%E6%96%B0.jpg)  

<br>
上图中我们看见的数据、筛选区域、UI结构全部都不是ZYSideSlipFilter决定的，all self-definition自定义。我们通过数据源(dataList)来跟Filter交流交换数据，包括我们的筛选条目的cell结构，我们的筛选条件，默认选择，和用户选择的结果。也就是说这是一个变化的数据源，像是一张调查问卷，进去是干净的，而出来是涂画过的。我们怎样通过Filter这个中间者去给用户填问卷呢？来看看```数据源```的结构图：  
![](https://raw.githubusercontent.com/liuzhiyi1992/MyStore/master/ZYSideSlipFilter/ZYSideSlipFilterModel%E7%BB%93%E6%9E%84%E5%9B%BE%E6%88%AA%E5%9B%BE%E6%9B%B4%E6%96%B0.jpg)  

#Structure
###ZYSideSlipFilterRegionModel和containerCellClass
图看起来有点复杂，没关系我们只需要认识最左边的```ZYSideSlipFilterRegionModel```，一个RegionModel代表一个筛选区域，也就是说我们需要在Filter里增加一个筛选区域，就创建一个RegionModel，Filter数据源里放的就是这个东西。而在RegionModel里面，最基本的我们只需要认识```containerCellClass```这个property, 它代表这个这个筛选区域的UI布局和逻辑代码所在的类(TableviewCell), 我们要求该自定义类继承自```SideSlipBaseTableViewCell```, ==自定义筛选区域tableViewCell，创建RegionModel，赋值containerCellClass，放进dataList，我们自己的Filter就能显示出来了==  

###配置筛选项
上图中我们可以看见Demo的3块筛选区域截图，下箭头对应了他们的RegionModel内容，最基本的containerCellClass配置好后，我们可以用```regionTitle```存储区域标题，用```itemList```来存储自定义的选项Model，```isShowAll```标识着是否展开全部选项，```selectedItemList```存储着用户选中的选项Model，这里再提一遍，用户发生交互后，我们是要修改RegionModel的，用户提交筛选时我们会拿到这些修改。对于以上这些property我们不用，或者不满足需求都没关系，```customDict```给你放任何附加内容。

###自适应cell高度
ZYSideSlipFilter会在每次reloadData时动态适配cell高度，前提是cell内subviews横向纵向都部署好了对tableViewContentView的自动约束，必须是对```ContentView```!!，对tableView无效!!  
如果需要设置固定高度，则可以重写父类SideSlipBaseTableViewCell的```+ cellHeight```方法即可。  

###SideSlipFilter数据交流的方法  
> 上面了解完如何去创建自己的Filter后，以下就是主要协同工作的api:  

![](https://raw.githubusercontent.com/liuzhiyi1992/MyStore/master/ZYSideSlipFilter/%E8%87%AA%E5%AE%9A%E4%B9%89%E7%AD%9B%E9%80%89%E5%8C%BA%E5%9F%9Fcell%E7%B1%BB%E7%BB%93%E6%9E%84%E5%9B%BE.png)


#Config
####**配置文件ZYSideSlipFilterConfig**
- FILTER\_NAVIGATION\_CONTROLLER\_CLASS  
Filter的导航控制器Class(构造方法只支持- initWithRootViewController:)  
- 各种UI参数

####**语言本地化Localizable.strings**  
目前配置了两个bottomButton的title string，有需要可以在自己项目的.strings文件中配置，不配置则默认为Reset, Commit
```
"sZYFilterReset" = "Reset";
"sZYFilterCommit" = "Commit";
``` 
<br>

#Usage  
####ZYSideSlipFilterController  
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
```objc
//need navigationBar?
[_filterController.navigationController setNavigationBarHidden:NO];
[_filterController setTitle:@"title"];
```
就是这样，我们的filter可以投向使用了吗？并不是，最重要的是我们的数据源dataList。数据源的结构见数据源结构图，ZYSideSlipFilter会按照数据源结构规则去工作起来。  

数据源准备好后, 让Filter显示出来
```objc
[_filterController show];
```

####自定义筛选RegionCell  
```objc
@interface Custom***TableViewCell : SideSlipBaseTableViewCell
```  
```objc
+ (NSString *)cellReuseIdentifier {
    //cellReuseIdentifier
}

+ (CGFloat)cellHeight {
    //option
    //you can use autolayout to cellContentView Rather than this func
}

+ (instancetype)createCellWithIndexPath:(NSIndexPath *)indexPath {
    //cell instance object
}

- (void)updateCellWithModel:(ZYSideSlipFilterRegionModel **)model
                  indexPath:(NSIndexPath *)indexPath {
    //update your cell
}

- (void)resetData {
    //option
    //respond while user click resetButton
```
>详细使用方法请参照Demo

<br>
###Demo自定义Region示意图
![](https://raw.githubusercontent.com/liuzhiyi1992/MyStore/master/ZYSideSlipFilter/Demo%E8%87%AA%E5%AE%9A%E4%B9%89%E7%AD%9B%E9%80%89%E5%8C%BA%E5%9F%9F%E7%A4%BA%E6%84%8F%E5%9B%BE%E8%A3%81%E5%89%AA.png)
<br>
###Demo所包含演示内容  
- 筛选项折叠展开
- 筛选项单双选
- 筛选区域push新页
- 筛选区域AutoLayout动态适配高度
- 用户当前操作筛选区域跟踪于屏幕垂直方向中央
- 不同类型的筛选区域插入Filter逻辑
- Reset / Commit 逻辑


<br>
#License  
ZYSideSlipFilter is released under the MIT license.
