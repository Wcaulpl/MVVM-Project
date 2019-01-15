//
//  XYFunctionDefine.m
//  XYBaseMVVM
//
//  Created by CETzxy on 2019/1/14.
//  Copyright © 2019年 Wcaulpl. All rights reserved.
//

#import "XYFunctionDefine.h"

#pragma mark - Decode
XY_EXTERN NSString * XYDecodeObjectFromDic(NSDictionary *dic, NSString *key)
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    NSString *value = @"";
    if (NotNilAndNull(temp))   {
        if ([temp isKindOfClass:[NSString class]]) {
            value = temp;
        }else if([temp isKindOfClass:[NSNumber class]]){
            value = [temp stringValue];
        }
        return value;
    }
    return nil;
}

XY_EXTERN NSString * XYDecodeDefaultStrFromDic(NSDictionary *dic, NSString *key,NSString * defaultStr)
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id temp = [dic objectForKey:key];
    NSString *value = defaultStr;
    if (NotNilAndNull(temp))   {
        if ([temp isKindOfClass:[NSString class]]) {
            value = temp;
        }else if([temp isKindOfClass:[NSNumber class]]){
            value = [temp stringValue];
        }
        
        return value;
    }
    return value;
}

XY_EXTERN id XYDecodeSafeObjectAtIndex(NSArray *arr, NSInteger index)
{
    if (IsArrEmpty(arr)) {
        return nil;
    }
    
    if ([arr count]-1<index) {
        XYAssert([arr count]-1<index);
        return nil;
    }
    
    return [arr objectAtIndex:index];
}



XY_EXTERN NSString * XYDecodeStringFromDic(NSDictionary *dic, NSString *key)
{
    if (IsNilOrNull(dic))
    {
        return nil;
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        if ([temp isEqualToString:@"(null)"]) {
            return @"";
        }
        return temp;
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return [temp stringValue];
    }
    return nil;
}

XY_EXTERN NSNumber * XYDecodeNumberFromDic(NSDictionary *dic, NSString *key)
{
    if (IsNilOrNull(dic))
    {
        return nil;
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSString class]])
    {
        return [NSNumber numberWithDouble:[temp doubleValue]];
    }
    else if ([temp isKindOfClass:[NSNumber class]])
    {
        return temp;
    }
    return nil;
}

XY_EXTERN NSDictionary * XYDecodeDicFromDic(NSDictionary *dic, NSString *key)
{
    if (IsNilOrNull(dic))
    {
        return nil;
    }
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSDictionary class]])
    {
        return temp;
    }
    return nil;
}

XY_EXTERN NSArray * XYDecodeArrayFromDic(NSDictionary *dic, NSString *key)
{
    id temp = [dic objectForKey:key];
    if ([temp isKindOfClass:[NSArray class]])
    {
        return temp;
    }
    return nil;
}

XY_EXTERN NSArray * XYDecodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic))
{
    NSArray *tempList = XYDecodeArrayFromDic(dic, key);
    if ([tempList count])
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[tempList count]];
        for (NSDictionary *item in tempList)
        {
            id dto = parseBlock(item);
            if (dto) {
                [array addObject:dto];
            }
        }
        return array;
    }
    return nil;
}


#pragma mark - Encode

XY_EXTERN void XYEncodeUnEmptyStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key)
{
    if (IsNilOrNull(dic))
    {
        return;
    }
    
    if (IsStrEmpty(object))
    {
        return;
    }
    
    if (IsStrEmpty(key))
    {
        return;
    }
    
    [dic setObject:object forKey:key];
}

XY_EXTERN void XYEncodeUnEmptyObjctToArray(NSMutableArray *arr,id object)
{
    if (IsNilOrNull(arr))
    {
        return;
    }
    
    if (IsNilOrNull(object))
    {
        return;
    }
    
    [arr addObject:object];
}

XY_EXTERN void XYEncodeDefaultStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key,NSString * defaultStr)
{
    if (IsNilOrNull(dic))
    {
        return;
    }
    
    if (IsStrEmpty(object))
    {
        object = defaultStr;
    }
    
    if (IsStrEmpty(key))
    {
        return;
    }
    
    [dic setObject:object forKey:key];
}

void XYEncodeUnEmptyObjctToDic(NSMutableDictionary *dic,NSObject *object, NSString *key)
{
    if (IsNilOrNull(dic))
    {
        return;
    }
    if (IsNilOrNull(object))
    {
        return;
    }
    if (IsStrEmpty(key))
    {
        return;
    }
    
    [dic setObject:object forKey:key];
}


