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
    
    
//    NSString *pathUrl = [[NSBundle mainBundle] pathForResource:@"tsz.txt" ofType:nil];
//    
//    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:pathUrl];
//    
//    TSZReaderFileInStream  *reader = [[TSZReaderFileInStream alloc] initWithFileAtPath: fileURL];
//    
//    [reader enumerateLines:^(NSUInteger lineNumber, NSString *line) {
//        
//        NSLog(@"lineNumber =  %zd  ,   line  =%@" , lineNumber , line);
//    } completion:^(NSUInteger lineNumbers) {
//        NSLog(@"%zd" , lineNumbers);
//    }];
    
    dispatch_apply(3, dispatch_get_global_queue(0, 0), ^(size_t  y) {
        
        for (size_t  x = 0 ;  x< 3; x++ ) {
            
            NSLog(@"次数 ： %zd" , x);
        }
        
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
