//
//  Seller.h
//  WeMakeAppsProducts
//
//  Created by Alexander Crompton on 1/12/2016.
//  Copyright © 2016 Alex Crompton Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Seller : NSObject
@property (nonatomic, strong)NSNumber *sellerID;
@property (nonatomic, strong)NSString *sellerName;

- (instancetype)initWithSellerID:(NSNumber *)sellerID andSellerName:(NSString*)sellerName;


@end
