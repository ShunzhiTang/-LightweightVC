//
//  TSZFileInStream.h
//  LightweightVC
//
//  Created by tang on 16/3/11.
//  Copyright © 2016年 shunzhitang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface TSZReaderFileInStream : NSObject

- (void)enumerateLines:(void (^)(  NSUInteger lineNumber,NSString * line)) block completion:(void (^)())completion;


- (instancetype)initWithFileAtPath:(NSURL *)pathUrl;



@end
