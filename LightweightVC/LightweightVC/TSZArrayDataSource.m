//
//  TSZArrayDataSource.m
//  LightweightVC
//
//  Created by tang on 16/3/11.
//  Copyright © 2016年 shunzhitang. All rights reserved.
//

#import "TSZArrayDataSource.h"


@interface TSZArrayDataSource ()


@property (nonatomic ,strong) NSArray *items;

@property (nonatomic ,copy) NSString *cellIdentifier;

@property (nonatomic ,copy) TableViewCellConfigureBlock  configureCellBlock;


@end

@implementation TSZArrayDataSource

- (instancetype)init{
    
    return  nil;
}

/**
 初始化 数组 ， id
 */
- (id)initWithItems:(NSArray * )aItems  cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureBlock{
    
    self = [super init];
    
    if (self) {
        
        self.items = aItems;
        self.cellIdentifier = aCellIdentifier;
        
        self.configureCellBlock = aConfigureBlock;
    }
    
    return  self;
}


/**
 indexPath  对应的 item
 */

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.items[ (NSUInteger)indexPath.row];
}


#pragma mark:  UItableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    id item = [self itemAtIndexPath:indexPath];
    
    self.configureCellBlock(cell , item);
    
    return cell;
}


@end
