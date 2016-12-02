//
//  ProductDetailTableViewCell.h
//  WeMakeAppsProducts
//
//  Created by Alexander Crompton on 1/12/2016.
//  Copyright © 2016 Alex Crompton Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *productDetailImageView;
@property (strong, nonatomic) IBOutlet UILabel *productDetailTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *productDetailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *productDetailPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *productDetailSellerLabel;
@property (strong, nonatomic) IBOutlet UILabel *productDetailSizesLabel;



@end
