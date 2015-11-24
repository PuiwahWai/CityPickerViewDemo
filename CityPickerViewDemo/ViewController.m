//
//  ViewController.m
//  CityPickerViewDemo
//
//  Created by HMN on 15/3/24.
//  Copyright (c) 2015年 HMN. All rights reserved.
//

#import "ViewController.h"
#import "CityPickerView.h"

@interface ViewController ()<CityPickerViewDelegate>
{
    ///阴影view
    UIView *bgView;
}
@property (nonatomic, strong) CityPickerView *cityView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    bgView = [[UIView alloc] initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    bgView.hidden = YES;
    [self.view addSubview:bgView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    self.cityView = [[CityPickerView alloc] initWithFrame:CGRectZero dataArray:[NSArray arrayWithContentsOfFile:path]];
    self.cityView.delegate = self;
    [self.view addSubview:self.cityView];
    
}
- (IBAction)clickSelectedButton:(id)sender {
    bgView.hidden = NO;
    [self.cityView showPickerView];
}

#pragma mark - UICityPickerView Delegate
- (void)clickCompleteButtonWithString:(NSString *)contentString
{
    NSLog(@"contentString--%@",contentString);
    self.cityLabel.text = [NSString stringWithFormat:@"城市：%@",contentString];
    bgView.hidden = YES;
}

- (void)clickCancelButton
{
    bgView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
