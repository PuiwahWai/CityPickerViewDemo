//
//  CityPickerView.m
//  HanNeng
//
//  Created by HMN on 15/3/23.
//  Copyright (c) 2015年 HMN. All rights reserved.
//

#import "CityPickerView.h"

#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation CityPickerView

- (id)initWithFrame:(CGRect)frame dataArray:(NSArray *)cityArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth, 44+216);
        
        self.cityArray = [[NSArray alloc] initWithArray:cityArray];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 44)];
        //bgImageView.image = [UIImage imageNamed:<#(NSString *)#>];
        bgImageView.backgroundColor = [UIColor colorWithRed:234.0f/255.0f green:234.0f/255.0f blue:234.0f/255.0f alpha:1];
        bgImageView.userInteractionEnabled = YES;
        [self addSubview:bgImageView];
        
        ///取消
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, 0, 60, 44);
        [cancelButton setTitle:@"关闭" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorWithRed:237.0f/255.0f green:101.0f/255.0f blue:105.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:cancelButton];
        
        ///完成
        UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        completeButton.frame = CGRectMake(kMainScreenWidth-60, 0, 60, 44);
        [completeButton setTitle:@"完成" forState:UIControlStateNormal];
        [completeButton setTitleColor:[UIColor colorWithRed:237.0f/255.0f green:101.0f/255.0f blue:105.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [completeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [completeButton addTarget:self action:@selector(clickCompleteButton) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView addSubview:completeButton];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, bgImageView.frame.size.height, kMainScreenWidth, 216)];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickerView];
        
        
    }
    return self;
}

#pragma mark dataSouce
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
    {
        return  self.cityArray.count;
        
    }else
    {
        return [[[self.cityArray objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] count];
    }
    
}
#pragma mark delegate
/**
//定义字体的大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == 0) {
        
        myView = [[UILabel alloc] init];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [[self.cityArray objectAtIndex:row] objectForKey:@"State"];
        
        myView.font = [UIFont systemFontOfSize:15];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
    }else {
        
        myView = [[UILabel alloc] init];
        
        myView.text = [[[[self.cityArray objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] objectAtIndex:row] objectForKey:@"city"];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:15];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    
    return myView;
}

//更改组键的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    
    CGFloat componentWidth = 0.0;
    
    
    if (component == 0)
        
        componentWidth = 100.0; // 第一个组键的宽度
    
    else
        
        componentWidth = 180.0; // 第2个组键的宽度
    
    
    return componentWidth;
    
}
//更改row的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 40.0;
    
}
*/

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [[self.cityArray objectAtIndex:row] objectForKey:@"State"];
    }
    else {
        return [[[[self.cityArray objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] objectAtIndex:row] objectForKey:@"city"];
    }
        
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0){
        self.rowInProvince = row;
        [self.pickerView reloadComponent:1];
    }
}

///显示pickerView
- (void)showPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, kMainScreenHeight-44-216, kMainScreenWidth, self.frame.size.height);
    } completion:^(BOOL finished) {
        ;
    }];
}
///隐藏pickerView
- (void)hidePickerView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, kMainScreenHeight, kMainScreenWidth, self.frame.size.height);
    } completion:^(BOOL finished) {
        ;
    }];
}
///关闭
- (void)clickCancelButton
{
    [self hidePickerView];
    
    if ([_delegate respondsToSelector:@selector(clickCompleteButtonWithString:)])
    {
        [_delegate clickCancelButton];
    }
}
///完成
- (void)clickCompleteButton
{
    [self hidePickerView];
    
    NSString *titleString = [NSString stringWithFormat:@"%@ %@",[[self.cityArray objectAtIndex:[self.pickerView selectedRowInComponent:0]] objectForKey:@"State"],[[[[self.cityArray objectAtIndex:self.rowInProvince] objectForKey:@"Cities"] objectAtIndex:[self.pickerView selectedRowInComponent:1]] objectForKey:@"city"]];
    
    if ([_delegate respondsToSelector:@selector(clickCompleteButtonWithString:)])
    {
        [_delegate clickCompleteButtonWithString:titleString];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
