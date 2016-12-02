//
//  ProductDetailTableViewController.h
//  WeMakeAppsProducts
//
//  Created by Alexander Crompton on 1/12/2016.
//  Copyright © 2016 Alex Crompton Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductDetailTableViewController : UITableViewController
@property (nonatomic, strong)Product *selectedProduct;

@end
