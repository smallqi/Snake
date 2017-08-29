//
//  SnakeView.m
//  Snake
//
//  Created by BlackApple on 2017/8/28.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "SnakeView.h"

@implementation SnakeView
{
    //记录蛇的数组
    NSMutableArray* snakeArray;
    //蛇的关节大小
    int radius;
    //记录当前食物的位置
    CGPoint food;
    //记录场地的格子数
    int width;
    int high;
    //游戏时间管理
    NSTimer* timer;
}

//重写构造函数
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //设置背景颜色为白色
        self.backgroundColor = [UIColor whiteColor];
        //初始化数据
        [self initData];
        //开始游戏
        [self startGame];
    }
    return self;
}
//初始化数据
-(void)initData{
    radius = 20;
    width = self.frame.size.width / radius;
    high = self.frame.size.height / radius;
    //初始化蛇的节点
    snakeArray = NULL;
    snakeArray = [[NSMutableArray alloc]init];
    self.length = 0;
    int i = width / 2;
    int j = high / 2;
    for(; i < width && self.length < 3; i++){
        CGPoint foodTemp = {i, j};
        [snakeArray addObject:NSStringFromCGPoint(foodTemp)];
        self.length++;
    }
    //初始化食物位置
    food = [self creatFood];
    //初始化方向
    self.direct = Up;
}
//创建食物位置
-(CGPoint)creatFood{
    CGPoint newPos;
    while (true) {
        newPos = CGPointMake(rand() % width, rand() % high);
        if(![snakeArray containsObject:NSStringFromCGPoint(newPos)])
            break;
    }
    NSLog(@"food is:%f,%f", newPos.x, newPos.y);
    return newPos;
}
//开始游戏
-(void)startGame{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(move) userInfo:nil repeats:true];
}
//游戏循环体
-(void)move{
    CGPoint next = CGPointFromString([snakeArray lastObject]);
    //判断当前前进的新方向
    switch (self.direct) {
        case Up:
            next.y--;
            break;
        case Down:
            next.y++;
            break;
        case Left:
            next.x--;
            break;
        case Right:
            next.x++;
            break;
        default:
            break;
    }
    //判断是否出界或者与自身相撞
    if(next.x < 0 || next.x > width - 1
       || next.y < 0 || next.y > high - 1
       ||[snakeArray containsObject:NSStringFromCGPoint(next)]){
        //游戏结束
        [timer invalidate];
        NSLog(@"GameOver");
        //重新开始
        [self initData];
        [self startGame];
        return;
    }
    //如果吃到食物
    if(CGPointEqualToPoint(next, food)){
        //食物位置直接成为新的蛇头，并且该贞不更新蛇的位置
        [snakeArray addObject:NSStringFromCGPoint(food)];
        //创建新的食物位置
        food = [self creatFood];
    }else{
        //前进更新位置
        int len = (int)snakeArray.count;
        for(int i=0; i<len-1; i++){
            //从尾巴开始，位置变换为前面一个关节的位置
            snakeArray[i] = snakeArray[i+1];
        }
        //更新头部
        snakeArray[len-1] = NSStringFromCGPoint(next);
    }
    //重新绘制
    [self setNeedsDisplay];
}

//重写绘制函数
- (void)drawRect:(CGRect)rect {
    //获取绘图api
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置绘制蛇的填充颜色
    CGContextSetRGBFillColor(context, 1, 1, 0, 1);
    //绘制蛇身
    int len = (int)snakeArray.count;
    for(int i=0; i<len; i++){
        CGPoint bodyPoint = CGPointFromString( [snakeArray objectAtIndex:i] );
        //定义绘制的矩形
        CGRect bodyRect = CGRectMake(bodyPoint.x*radius, bodyPoint.y*radius, radius, radius);
        //进行绘制
        CGContextFillEllipseInRect(context, bodyRect);
    }
    //绘制食物
    CGRect foodRect = CGRectMake(food.x*radius, food.y*radius, radius, radius);
    CGContextFillEllipseInRect(context, foodRect);
}

@end
