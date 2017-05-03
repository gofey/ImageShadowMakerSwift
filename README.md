# ImageShadowMakerSwift
已经有一个OC版本了，写一个Swift版福利大家

![images](http://ooy23086i.bkt.clouddn.com/show1.png)

![images](http://ooy23086i.bkt.clouddn.com/show2.png)

![images](http://ooy23086i.bkt.clouddn.com/show3.png)

使用方式很简单

    self.view.addSubview(imgView)
    imgView.isUserInteractionEnabled = true
    imgView.image = #imageLiteral(resourceName: "image0")
    imgView.cornerRadius = 5

需要改变阴影半径或者阴影偏移，可以设置shadowOffSet，shadowRadius属性，圆角属性cornerRadius

甚至可以自己定制自己想要的阴影颜色
imageView.layer.shadowColor = [UIColor redColor].CGColor//需要基于layer层改变

觉得图片不需要，可以不设置图片，也就变成了一个单纯的阴影背景，你可以往里面添加内容，让其做你的阴影背景，效果也是一样的，但是注意要把frame设置的和你想要添加背景的view设置成一样，CornerRadius等属性也要一样，如下

    //OC语言的，但用法相似 
    
    ImageShadowView *imageView = [[ImageShadowView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 50, [UIScreen mainScreen].bounds.size.height / 2 - 50, 100, 100)];
    [self.view addSubview:imageView];
    imageView.cornerRadius = 10;

    UIView *contentView = [[UIView alloc] initWithFrame:imageView.frame];
    [self.view addSubview:contentView];
    contentView.layer.cornerRadius = 10;//切圆角
    contentView.layer.masksToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];//很重要,一定要设置背景色，不然会看到后边阴影的颜色
    imageView.layer.shadowColor = [UIColor redColor].CGColor;//阴影颜色设置
    
效果：

![images](http://ooy23086i.bkt.clouddn.com/show4.png)
