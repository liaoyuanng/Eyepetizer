//  Created by Ju Liaoyuan on 2018/3/9.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYNetworkParameter : NSObject

/**
 all keys
 */
@property (nonatomic, copy, readonly) NSArray *keys;

/**
 all values
 */
@property (nonatomic, copy, readonly) NSArray *values;

/**
 collection of keys and values.
 */
@property (nonatomic, copy, readonly) NSDictionary *result;

/**
 Convenience Initializers
 
 NOTE: keys and values must be in the order

 @param keys all keys array
 @param value all values array
 @return a newworkparameter object, or nil if error occurs
 */
- (instancetype)initWithKeys:(NSArray *)keys values:(id )value, ... NS_REQUIRES_NIL_TERMINATION;

/**
 config data

 NOTE: keys and values must be in the order
 
 @param keys all keys
 @param values all value
 @return result
 */
- (instancetype)combineKeys:(NSArray *)keys values:(NSArray *)values;

+ (instancetype)parameteWithKeys:(NSArray *)keys values:(id)value, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark - method

///**
// replace an old key by index.
// */
//- (void)replaceKey:(id)newKey AtIndex:(NSUInteger)index;
//
///**
// replace an old key by newKey.
// */
//- (void)replaceKey:(id)newKey oldKey:(id)oldKey;
//
///**
// replace an old value by index.
// */
//- (void)replaceValue:(id)newValue AtIndex:(NSUInteger)index;
//
/**
 replace an old value by new value.
 */
//- (void)replaceValue:(id)newValue oldValue:(id)oldValue;

/**
 replace value by key
 */
- (void)replaceValue:(id)newValue byKey:(id)key;
//
///**
// remove a key - value object.
// */
//- (void)removeObjectAtIndex:(NSUInteger)index;
//
///**
// remove key - value.
// 
// NOTE: The method will remove the corresponding value / key.
// If there is the same key or value in the collection, it will be removed.
// 
// //////////////////////////////////////////////////////////////////////
// /// e.g.:
// ///
// /// {"name":"fzw","job":"iOS","fzw":"shanghai","iOS":"Objective - C"}
// ///
// /// it will be remove all. you will get a empty json.
// /// So, make sure the key or value is unique
// //////////////////////////////////////////////////////////////////////
// 
// if you jsut want remove key or value only. see `- removeKey:` or `- removeValue:`
// 
// @param object key or value
// */
//- (void)removeObject:(id)object;
//
///**
// remove key and key corresponding value
// */
//- (void)removeKey:(id)key;
//
///**
// remove value and value corresponding key
// */
//- (void)removeValue:(id)value;
//
///**
// add object.
// */
//- (void)addObject:(NSDictionary *)object;

@end

NS_ASSUME_NONNULL_END
