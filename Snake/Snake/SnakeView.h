//
//  SnakeView.h
//  Snake
//
//  Created by BlackApple on 2017/8/28.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <UIKit/UIKit.h>
//蛇的方向
enum Direct{
    Up = 0,
    Down,
    Left,
    Right
};

@interface SnakeView : UIView
//蛇头当前方向
@property enum Direct direct;
//蛇身长度
@property int length;

@end
