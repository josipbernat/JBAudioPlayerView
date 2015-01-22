# JBAudioPlayerView
Simple view component for playing audio files in iOS. Suitable for usage in UITableView and UICollectionView.

![alt tag](http://url/to/img.png)

## USAGE
You can use it from Storyboards, XIBs or directly from code. It uses AutoLayou by default but if you wish to turn it off just set useAutoLayout to NO.

```objective-c
JBAudioPlayerView *fromCode = [[JBAudioPlayerView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 200.0f, 50.0f)];
fromCode.backgroundColor = [UIColor yellowColor];
fromCode.useAutoLayout = NO;
[self.view addSubview:fromCode];
```

