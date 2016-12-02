//
//  Product.m
//  WeMakeAppsProducts
//
//  Created by Alexander Crompton on 1/12/2016.
//  Copyright © 2016 Alex Crompton Design. All rights reserved.
//

#import "Product.h"


@implementation Product

- (instancetype)initWithProductID:(NSNumber *)productID andProductTitle:(NSString *)productTitle andProductPrice:(NSNumber *)productPrice andProductDescription:(NSString*)productDescription andProductImageURL:(NSURL *)productImageURL andProductSizes:(NSArray *)productSizes andProductSeller:(Seller *)productSeller{
    if (self = [super init]) {
        self.productID = _productID;
        self.productPrice = _productPrice;
        self.productSizes = _productSizes;
        self.productTitle = _productTitle;
        self.productSeller = _productSeller;
        self.productImageURL = _productImageURL;
        self.productDescription = _productDescription;
    }
    return self;
    
}
//parse products JSON from http://wemakeapps.net/hats/products.json
+ (NSArray *)productsWithJSONData:(NSData*)jsonData{
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    NSArray *productsJSONArray = [jsonDictionary objectForKey:@"products"];
    NSMutableArray *productsMutableArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dictionary in productsJSONArray) {
        Product *product = [[Product alloc]init];
        [product setProductID:dictionary[@"id"]];
        [product setProductTitle:dictionary[@"title"]];
        [product setProductPrice:dictionary[@"price"]];
        [product setProductImageURL:[NSURL URLWithString:dictionary[@"imageUrl"]]];
        [product setProductDescription:dictionary[@"description"]];
        NSArray *sizesArray = dictionary[@"sizes"];
        NSMutableArray *sizesMutableArray = [[NSMutableArray alloc]init];
        
        for (NSString *size in sizesArray) {
            [sizesMutableArray addObject:size];
        }
        
        [product setProductSizes:sizesMutableArray];
        NSDictionary *sellerDictionary = dictionary[@"seller"];
        Seller *seller = [[Seller alloc]init];
        [seller setSellerID:sellerDictionary[@"id"]];
        [seller setSellerName:sellerDictionary[@"name"]];
        [product setProductSeller:seller];
        
        [productsMutableArray addObject:product];
        
    }
    return [productsMutableArray copy];
}

+ (NSMutableAttributedString*)attributedStringForProductListWithProduct:(Product *)product{
    double productPriceDouble = [[product productPrice]doubleValue];
    NSString *text = [NSString stringWithFormat:@"%@\n%@\nSold By\n%@", product.productTitle, [self formatCurrencyWithPrice:productPriceDouble], [product productSeller].sellerName];
    NSMutableAttributedString *productAttributedString = [[NSMutableAttributedString alloc]initWithString:text];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle1]
                                    range:[[productAttributedString string] rangeOfString:product.productTitle]];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle3]
                                    range:[[productAttributedString string] rangeOfString:[self formatCurrencyWithPrice:productPriceDouble]]];
    
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleCallout]
                                    range:[[productAttributedString string] rangeOfString:[NSString stringWithFormat:@"Sold By\n%@", [product productSeller].sellerName]]];
    return productAttributedString;
}

+ (NSString*)formatCurrencyWithPrice:(double)price{
    price = price / 100;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:price]];
    return numberAsString;
}


+ (NSMutableAttributedString*)attributedProductTitleStringForProduct:(Product*)product{
    NSMutableAttributedString *productAttributedString = [[NSMutableAttributedString alloc]initWithString:product.productTitle];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle1]
                                    range:[[productAttributedString string] rangeOfString:product.productTitle]];
    return productAttributedString;
    
}

+ (NSMutableAttributedString*)attributedProductDescriptionStringForProduct:(Product*)product{
    NSMutableAttributedString *productAttributedString = [[NSMutableAttributedString alloc]initWithString:product.productDescription];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]
                                    range:[[productAttributedString string] rangeOfString:product.productDescription]];
    return productAttributedString;
}

+ (NSMutableAttributedString*)attributedProductPriceStringForProduct:(Product*)product{
    double productPriceDouble = [[product productPrice]doubleValue];
    NSString *priceString = [self formatCurrencyWithPrice:productPriceDouble];

    NSMutableAttributedString *productAttributedString = [[NSMutableAttributedString alloc]initWithString:priceString];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle2]
                                    range:[[productAttributedString string] rangeOfString:[self formatCurrencyWithPrice:productPriceDouble]]];
    return productAttributedString;
}

+ (NSMutableAttributedString*)attributedProductSellerStringForProduct:(Product*)product{
    NSMutableAttributedString *productAttributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Sold By\n%@", product.productSeller.sellerName]];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]
                                    range:[[productAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@", product.productSeller.sellerName]]];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle2]
                                    range:[[productAttributedString string] rangeOfString:[NSString stringWithFormat:@"Sold By"]]];
    
    return productAttributedString;
}

+ (NSMutableAttributedString*)attributedProductSizesStringForProduct:(Product*)product{
    NSMutableString *sizesString = [[NSMutableString alloc]initWithString:@""];
    for (NSString *size in product.productSizes) {
        if (size == [product.productSizes lastObject]) {
            [sizesString appendString:[NSString stringWithFormat:@"%@", size]];
        }
        else{
            [sizesString appendString:[NSString stringWithFormat:@"%@, ", size]];
        }
    }
    NSMutableAttributedString *productAttributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"Available Sizes\n%@", sizesString]];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleTitle2]
                                    range:[[productAttributedString string] rangeOfString:[NSString stringWithFormat:@"Available Sizes"]]];
    [productAttributedString addAttribute:NSFontAttributeName
                                    value:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]
                                    range:[[productAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@", sizesString]]];
    
    return productAttributedString;
}

//generate thumbnail image for use in products list
+ (UIImage*)smallThumbnailOfProductImage:(UIImage*)image{
    UIImage *originalImage = image;
    CGSize destinationSize = CGSizeMake(100, 100);
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}
//generate thumbnail image for use in product detail
+ (UIImage*)largeThumbnailOfProductImage:(UIImage*)image{
    UIImage *originalImage = image;
    CGSize destinationSize = CGSizeMake(300, 300);
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}


@end
