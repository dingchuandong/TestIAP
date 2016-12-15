//
//  ZM_SelectPriceView.m
//  begin
//
//  Created by dcd on 16/11/5.
//  Copyright © 2016年 上海宅米贸易有限公司. All rights reserved.
//

#import "ZM_SelectPriceView.h"

@implementation ZM_SelectPriceView

-(id)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        bgImg.image = mImageByName(@"priceBgImg");
        [self addSubview:bgImg];
        
        _priceBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 12.5, 50, 20)];
        _priceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_priceBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_priceBtn setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:255/255.0
                                                                                 green:85/255.0
                                                                                  blue:114/255.0
                                                                                 alpha:1]] forState:UIControlStateSelected];
        _priceBtn.layer.borderWidth = 0.5;
        _priceBtn.layer.cornerRadius = 10;
        _priceBtn.layer.masksToBounds = YES;
        [self addSubview:_priceBtn];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 70, 25)];
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = [UIColor blackColor];
        [self addSubview:_titleLab];
    }
    return self;
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
