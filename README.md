# JBAudioPlayerView
Simple view component for playing audio files in iOS. Suitable for usage in UITableView and UICollectionView.

![alt tag](https://cloud.githubusercontent.com/assets/2537227/5857444/204ac438-a24c-11e4-95e7-75aa4981d351.png)

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like JBMessage in your projects.

#### Podfile

```ruby
platform :ios, '7.0'
pod 'JBAudioPlayerView'
```

## USAGE
You can use it from Storyboards, XIBs or directly from code. It uses AutoLayou by default but if you wish to turn it off just set useAutoLayout to NO.

```objective-c
JBAudioPlayerView *fromCode = [[JBAudioPlayerView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 200.0f, 50.0f)];
fromCode.backgroundColor = [UIColor yellowColor];
fromCode.useAutoLayout = NO;
[self.view addSubview:fromCode];
```

