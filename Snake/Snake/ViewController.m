//
//  ViewController.m
//  Snake
//
//  Created by BlackApple on 2017/8/28.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "ViewController.h"
#import "SnakeView.h"

@interface ViewController ()

@property(strong, nonatomic)SnakeView* snakeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建场景
    self.snakeView = [[SnakeView alloc]initWithFrame:self.view.frame];
    //设置圆角
    self.snakeView.layer.cornerRadius = 6;
    self.snakeView.layer.masksToBounds = YES;
    //设置边框
    self.snakeView.layer.borderWidth = 3;
    self.snakeView.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.view addSubview:self.snakeView];
    
    //设置视图支持用户交互
    self.view.userInteractionEnabled = true;
    //设置视图支持多点触碰
    self.view.multipleTouchEnabled = true;
    //创建四个方向手势处理器
    for(int i=0; i<4; i++){
        //创建处理轻扫手势的手势处理器
        UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
        //只处理一个手指
        gesture.numberOfTouchesRequired = 1;
        //指定轻扫方向
        gesture.direction = 1<<i;
        //添加该控制器
        [self.view addGestureRecognizer:gesture];
    }
}
//触发方法
- (void)handleSwipe:(UISwipeGestureRecognizer*)gesture {
    //获取轻扫手势
    NSUInteger direction = gesture.direction;
    //更改蛇头方向
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            if(self.snakeView.direct != Right)
                self.snakeView.direct = Left;
            NSLog(@"Left");
            break;
        case UISwipeGestureRecognizerDirectionRight:
            if (self.snakeView.direct != Left) {
                self.snakeView.direct = Right;
            }
            NSLog(@"Right");
            break;
        case UISwipeGestureRecognizerDirectionUp:
            if (self.snakeView.direct != Down) {
                self.snakeView.direct = Up;
            }
            NSLog(@"Up");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            if (self.snakeView.direct != Up) {
                self.snakeView.direct = Down;
            }
            NSLog(@"Down");
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
