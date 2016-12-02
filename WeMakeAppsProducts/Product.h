//
//  Product.h
//  WeMakeAppsProducts
//
//  Created by Alexander Crompton on 1/12/2016.
//  Copyright © 2016 Alex Crompton Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Seller.h"
#import <UIKit/UIKit.h>
@interface Product : NSObject
@property (nonatomic, strong)NSNumber *productID;
@property (nonatomic, strong)NSString *productTitle;
@property (nonatomic, strong)NSNumber *productPrice;
@property (nonatomic, strong)NSString *productDescription;
@property (nonatomic, strong)NSURL *productImageURL;
@property (nonatomic, strong)NSArray *productSizes;
@property (nonatomic, strong)Seller *productSeller;

- (instancetype)initWithProductID:(NSNumber *)productID andProductTitle:(NSString *)productTitle andProductPrice:(NSNumber *)productPrice andProductDescription:(NSString*)productDescription andProductImageURL:(NSURL *)productImageURL andProductSizes:(NSArray *)productSizes andProductSeller:(Seller *)productSeller;

+ (NSArray *)productsWithJSONData:(NSData*)jsonData;

+ (NSMutableAttributedString*)attributedStringForProductListWithProduct:(Product *)product;
+ (NSMutableAttributedString*)attributedProductTitleStringForProduct:(Product*)product;
+ (NSMutableAttributedString*)attributedProductDescriptionStringForProduct:(Product*)product;
+ (NSMutableAttributedString*)attributedProductPriceStringForProduct:(Product*)product;
+ (NSMutableAttributedString*)attributedProductSellerStringForProduct:(Product*)product;
+ (NSMutableAttributedString*)attributedProductSizesStringForProduct:(Product*)product;
+ (UIImage*)smallThumbnailOfProductImage:(UIImage*)image;
+ (UIImage*)largeThumbnailOfProductImage:(UIImage*)image;







@end
