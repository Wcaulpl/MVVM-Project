//
//  XYFunctionDefine.h
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Encode Decode 方法
// NSDictionary -> NSString
XY_EXTERN NSString * XYDecodeObjectFromDic(NSDictionary *dic, NSString *key);
// NSArray + index -> id
XY_EXTERN id        XYDecodeSafeObjectAtIndex(NSArray *arr, NSInteger index);
// NSDictionary -> NSString
XY_EXTERN NSString * XYDecodeStringFromDic(NSDictionary *dic, NSString *key);
// NSDictionary -> NSString ？ NSString ： defaultStr
XY_EXTERN NSString * XYDecodeDefaultStrFromDic(NSDictionary *dic, NSString *key,NSString *defaultStr);
// NSDictionary -> NSNumber
XY_EXTERN NSNumber * XYDecodeNumberFromDic(NSDictionary *dic, NSString *key);
// NSDictionary -> NSDictionary
XY_EXTERN NSDictionary * XYDecodeDicFromDic(NSDictionary *dic, NSString *key);
// NSDictionary -> NSArray
XY_EXTERN NSArray * XYDecodeArrayFromDic(NSDictionary *dic, NSString *key);
XY_EXTERN NSArray * XYDecodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic));

#pragma mark - Encode Decode 方法
// (nonull Key: nonull NSString) -> NSMutableDictionary
XY_EXTERN void XYEncodeUnEmptyStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key);
// nonull objec -> NSMutableArray
XY_EXTERN void XYEncodeUnEmptyObjctToArray(NSMutableArray *arr,id object);
// (nonull (Key ? key : defaultStr) : nonull Value) -> NSMutableDictionary
XY_EXTERN void XYEncodeDefaultStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key,NSString *defaultStr);
// (nonull Key: nonull object) -> NSMutableDictionary
XY_EXTERN void XYEncodeUnEmptyObjctToDic(NSMutableDictionary *dic,NSObject *object, NSString *key);
