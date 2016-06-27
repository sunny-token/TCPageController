//
//  SNDJHCategoryListDTO.h
//  SuningEBuy
//
//  Created by sh on 16/3/2.
//  Copyright © 2016年 苏宁易购. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryListDTO : NSObject

@property (nonatomic,strong) NSString   *categName;
@property (nonatomic,strong) NSString   *categCode;
@property (nonatomic,strong) NSString   *categSeq;
@property (nonatomic,strong) NSString   *pcImageUrl;
@property (nonatomic,strong) NSString   *wapImageUrl;
@property (nonatomic,strong) NSString   *labelId;

+ (CategoryListDTO *)parse:(NSDictionary *)dic;
@end
