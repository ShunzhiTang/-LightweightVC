//
//  TSZArrayDataSource.h
//  LightweightVC
//
//  Created by tang on 16/3/11.
//  Copyright © 2016年 shunzhitang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//  typedef 相当于起别名

typedef void (^TableViewCellConfigureBlock)(id  cell , id  item);

@interface TSZArrayDataSource : NSObject <UITableViewDataSource>

/**
    初始化 数组 ， id
 */
- (id)initWithItems:(NSArray * )aItems  cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureBlock;


/**
    indexPath  对应的 item
 */

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;


@end
