//
//  SNDJHCategoryListDTO.m
//  SuningEBuy
//
//  Created by sh on 16/3/2.
//  Copyright © 2016年 苏宁易购. All rights reserved.
//

#import "CategoryListDTO.h"

@implementation CategoryListDTO

+ (CategoryListDTO *)parse:(NSDictionary *)dic{
    CategoryListDTO *dto = [[CategoryListDTO alloc] init];
    if(dic && [dic isKindOfClass:[NSDictionary class]]){
        dto.categName  = [dic objectForKey:@"categName"];
        dto.categCode = [dic objectForKey:@"categCode"];
        dto.categSeq = [dic objectForKey:@"categSeq"];
        dto.pcImageUrl = [dic objectForKey:@"pcImageUrl"];
        dto.wapImageUrl = [dic objectForKey:@"wapImageUrl"];
        dto.labelId = [dic objectForKey:@"labelId"];
    }
    return dto;
}
@end
