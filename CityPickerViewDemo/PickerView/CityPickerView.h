//
//  CityPickerView.h
//  HanNeng
//
//  Created by HMN on 15/3/23.
//  Copyright (c) 2015年 HMN. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CityPickerViewDelegate;

@interface CityPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

///城市数组
@property (nonatomic, strong) NSArray *cityArray;
///选择行数
@property (assign ,nonatomic) NSInteger rowInProvince;

///选择器
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, assign) id<CityPickerViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame dataArray:(NSArray *)cityArray;

///显示pickerView
- (void)showPickerView;
///隐藏pickerView
- (void)hidePickerView;

@end


@protocol CityPickerViewDelegate <NSObject>

///点击关闭
- (void)clickCancelButton;

///点击完成
- (void)clickCompleteButtonWithString:(NSString *)contentString;

@end


