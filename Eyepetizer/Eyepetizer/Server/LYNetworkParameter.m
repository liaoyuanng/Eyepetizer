//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 J. All rights reserved.
//

#import "LYNetworkParameter.h"

@interface LYNetworkParameter ()

@property (nonatomic, copy) NSArray *keys;

@property (nonatomic, copy) NSArray *values;

@property (nonatomic, copy) NSDictionary *result;

@end

@implementation LYNetworkParameter

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithKeys:(NSArray *)keys values:(id)value, ... {
    
    NSMutableArray *values = [NSMutableArray array];
    va_list argsList;
    [values addObject:value];
    va_start(argsList, value);
    id arg;
    while ((arg = va_arg(argsList, id))) {
        [values addObject:arg];
    }
    va_end(argsList);

    [self combineKeys:keys values:values.copy];
    
    return [self init];
}

+ (instancetype)parameteWithKeys:(NSArray *)keys values:(id)value, ... {
    
    LYNetworkParameter *para = [[LYNetworkParameter alloc] init];
    
    NSMutableArray *values = [NSMutableArray array];
    va_list argsList;
    [values addObject:value];
    va_start(argsList, value);
    id arg;
    while ((arg = va_arg(argsList, id))) {
        [values addObject:arg];
    }
    va_end(argsList);
    
    [para combineKeys:keys values:values.copy];

    return para;
}

- (instancetype)combineKeys:(NSArray *)keys values:(NSArray *)values {
    if (keys.count == 0 || values.count == 0) return nil;
    
    // prevent app crash when value is nil
    NSString *log = [NSString stringWithFormat:@"📣 第%d参数的值为 nil, 请检查参数对应的值",(int)values.count];
    
    NSAssert(keys.count == values.count, log);
    
    NSMutableDictionary *tempDict = [NSMutableDictionary new];
    
    self.keys = keys;
    self.values = values;
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempDict setObject:[self.values objectAtIndex:idx] forKey:keys[idx]];
    }];
    self.result = tempDict.copy;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ : %p; %@",self,self,self.result];
}



#pragma mark - method
#pragma mark

//- (void)replaceValue:(id)newValue oldValue:(id)oldValue {
//
//    if (!newValue || !oldValue) return;
//
//    NSUInteger index = [self.values indexOfObject:oldValue];
//    if (index != NSNotFound) {
//        id key = self.keys[index];
//        if (key) {
//            NSMutableArray *temp = self.values.mutableCopy;
//            [temp replaceObjectAtIndex:index withObject:newValue];
//            self.values = temp.copy;
//        }
//    }
//
//}
//
//- (void)replaceKey:(id)newKey oldKey:(id)oldKey {
//
//    if (!newKey || !oldKey) return;
//
//    if ([self.keys containsObject:oldKey]) {
//        NSMutableArray *tempArr = self.keys.mutableCopy;
//        [tempArr replaceObjectAtIndex:[self.keys indexOfObject:oldKey] withObject:newKey];
//
//        NSMutableDictionary *tempDict = self.result.mutableCopy;
//        id value = [tempDict objectForKey:oldKey];
//        [tempDict removeObjectForKey:oldKey];
//        [tempDict setObject:value forKey:newKey];
//    }
//}

- (void)replaceValue:(id)newValue byKey:(id)key {
    NSUInteger index = [self.keys indexOfObject:key];
    if (index == NSNotFound) return;
    NSMutableArray *temp = self.values.mutableCopy;
    [temp replaceObjectAtIndex:index withObject:newValue];
    self.values = temp.copy;
    [self combineKeys:self.keys values:self.values];
}



@end
