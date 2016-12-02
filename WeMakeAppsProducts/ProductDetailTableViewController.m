//
//  ProductDetailTableViewController.m
//  WeMakeAppsProducts
//
//  Created by Alexander Crompton on 1/12/2016.
//  Copyright © 2016 Alex Crompton Design. All rights reserved.
//

#import "ProductDetailTableViewController.h"
#import "Product.h"
#import "Seller.h"
#import "UIImageView+AFNetworking.h"
#import "ProductDetailTableViewCell.h"


@interface ProductDetailTableViewController ()

@end

@implementation ProductDetailTableViewController
@synthesize selectedProduct;

- (void)viewWillAppear:(BOOL)animated{
    [self configureNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension; //use autolayout to determine cell height
    self.tableView.estimatedRowHeight = 100;
    [self.tableView registerClass:[ProductDetailTableViewCell class] forCellReuseIdentifier:@"Cell"]; //register the custom cell to work with our tableview

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailCell" owner:self options:nil];
    ProductDetailTableViewCell *cell = [nib objectAtIndex:0];
    
    //unlimited lines for our 5 labels
    [[cell productDetailTitleLabel]setNumberOfLines:0];
    [[cell productDetailDescriptionLabel]setNumberOfLines:0];
    [[cell productDetailPriceLabel]setNumberOfLines:0];
    [[cell productDetailSellerLabel]setNumberOfLines:0];
    [[cell productDetailSizesLabel]setNumberOfLines:0];
    
    
    [[cell productDetailTitleLabel]setAttributedText:[Product attributedProductTitleStringForProduct:selectedProduct]];
    [[cell productDetailDescriptionLabel]setAttributedText:[Product attributedProductDescriptionStringForProduct:selectedProduct]];
     [[cell productDetailPriceLabel]setAttributedText:[Product attributedProductPriceStringForProduct:selectedProduct]];
     [[cell productDetailSellerLabel]setAttributedText:[Product attributedProductSellerStringForProduct:selectedProduct]];
    [[cell productDetailSizesLabel]setAttributedText:[Product attributedProductSizesStringForProduct:selectedProduct]];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:selectedProduct.productImageURL];
    __weak ProductDetailTableViewCell *weakCell = cell; //weak reference to cell avoids retain cycle and memory leak issues
    
    
    [cell.productDetailImageView setImageWithURLRequest:request
                          placeholderImage:[UIImage imageNamed:@"placeholder"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       [[weakCell productDetailImageView]setImage:[Product largeThumbnailOfProductImage:image]];
                                       weakCell.productDetailImageView.contentMode = UIViewContentModeScaleAspectFit;
                                       weakCell.productDetailImageView.autoresizingMask = UIViewAutoresizingNone;
                                       [weakCell setNeedsLayout];
                                       
                                       
                                   } failure:nil];
    
    return cell;
}

- (void)configureNavigationBar{
    [[self navigationItem]setTitle:selectedProduct.productTitle];
}




@end
