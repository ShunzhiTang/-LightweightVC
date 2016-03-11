//
//  ViewController.m
//  LightweightVC
//
//  Created by tang on 16/3/11.
//  Copyright © 2016年 shunzhitang. All rights reserved.

#import "ViewController.h"
#import "TSZReaderFileInStream.h"
@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
   
    
     NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:@"/Users/tang/Desktop/tsz.txt"];
    
     TSZReaderFileInStream  *reader = [[TSZReaderFileInStream alloc] initWithFileAtPath: fileURL];
    
    [reader enumerateLines:^(NSUInteger lineNumber, NSString *line) {
        
        NSLog(@"lineNumber =  %zd  ,   line  =%@" , lineNumber , line);
    } completion:^{
        
        NSLog(@"completion");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
