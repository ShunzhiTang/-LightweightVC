//
//  TSZFileInStream.m
//  LightweightVC
//
//  Created by tang on 16/3/11.
//  Copyright © 2016年 shunzhitang. All rights reserved.
//

#import "TSZReaderFileInStream.h"

#import "NSData+EnumerateComponents.h"

@interface TSZReaderFileInStream ()  <NSStreamDelegate>

@property (nonatomic , strong) NSOperationQueue *queue;

@property (nonatomic , strong) NSInputStream *inputStream;

@property (nonatomic ,copy) void (^callBlock)( NSUInteger lineNumber,NSString * line) ;

@property (nonatomic ,copy) void (^completion)(NSUInteger lineNumbers);

@property (nonatomic ,strong) NSURL  *fileUrl;


@property (nonatomic ,copy) NSData *delimiter;

@property (nonatomic ,assign) NSUInteger lineNumber;

@property (nonatomic ,strong) NSMutableData  *remaider;

@end

@implementation TSZReaderFileInStream

- (void)enumerateLines:(void (^)(  NSUInteger lineNumber,NSString * line)) block completion:(void (^)(NSUInteger lineNumbers))completion{
    
    
    if (self.queue == nil) {
        
        _queue = [[NSOperationQueue alloc] init];
        
        self.queue.maxConcurrentOperationCount  =  1 ;
    }
    
//    NSAssert(self.queue.maxConcurrentOperationCount == 1, @"queue can't  ");
    
    self.callBlock = block;
    self.completion = completion;
    self.inputStream = [NSInputStream   inputStreamWithURL:self.fileUrl];
    
    self.inputStream.delegate = self;
        
    [self.inputStream  scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.inputStream open];
}


- (id)initWithFileAtPath:(NSURL *)pathUrl{
    
    if (![pathUrl isFileURL]) {
        return nil;
    }
    
    self = [super init];
    
    if (self) {
        
        self.fileUrl =  pathUrl;
        
        NSData *data = [self.inputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.delimiter  = [string dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    
    return self;
}

#pragma mark: NSStramDelegate的代理方法


- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    
    NSLog(@"-----");
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            
            break;
        
        case NSStreamEventEndEncountered :
        {
            [self emitLineWithData:self.remaider];
            
            self.remaider = nil;
            
            [aStream close];
            
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            
            aStream = nil;
            
            [self.queue addOperationWithBlock:^{
                self.completion(self.lineNumber + 1);
            }];
            
             break;
        }
            
            
            case NSStreamEventErrorOccurred:
            
            NSLog(@"error");
            
            break;
            
            case NSStreamEventHasBytesAvailable:
        {
            NSMutableData *buffer = [NSMutableData dataWithLength: 4 * 1024];
            NSUInteger length = [self.inputStream  read:[buffer mutableBytes] maxLength:[buffer length]];
            
            if (0 < length) {
                
                [buffer setLength:length ];
                
                __weak id weakSelf = self;
                
                [self.queue addOperationWithBlock:^{
                    
                    [weakSelf processDataChunk:buffer];
                    
                }];
                
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)emitLineWithData:(NSData *)data{
    
    NSUInteger lineNumber = self.lineNumber;
    
    if (0 < data.length) {
        
        NSString *line  = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding ];
        
        self.callBlock(lineNumber ,line);
    }
}

- (void)processDataChunk:(NSMutableData *)buffer{
    
    if (self.remaider  != nil) {
        
        [self.remaider  appendData:buffer];
    }else{
        
        self.remaider = buffer;
    }
    
    
    [self.remaider  obj_enumerateComponentsSeparatedBy:self.delimiter usingBlock:^(NSData * completion, BOOL finalBlock) {
        
        if (!finalBlock) {
            
            [self emitLineWithData:completion];
        }else if(0 < [completion length]){
            
            self.remaider  = [completion mutableCopy];
        }else{
            
            self.completion = nil;
        }
        
    }];
}


@end
