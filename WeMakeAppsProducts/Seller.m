//
//  Seller.m
//  WeMakeAppsProducts
//
//  Created by Alexander Crompton on 1/12/2016.
//  Copyright © 2016 Alex Crompton Design. All rights reserved.
//

#import "Seller.h"

@implementation Seller

- (instancetype)initWithSellerID:(NSNumber *)sellerID andSellerName:(NSString*)sellerName{
    if (self = [super init]) {
        self.sellerID = _sellerID;
        self.sellerName = _sellerName;
    }
    return self;
}


@end
