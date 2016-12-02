//
//  ProductsTableViewController.m
//  WeMakeAppsProducts
//
//  Created by Alexander Crompton on 1/12/2016.
//  Copyright © 2016 Alex Crompton Design. All rights reserved.
//

#import "ProductsTableViewController.h"
#import "Product.h"
#import "Seller.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "ProductDetailTableViewController.h"


@interface ProductsTableViewController ()
@property (nonatomic, strong)NSArray *productsArray; //this array holds the Products
@property (nonatomic, strong)Product *selectedProduct; //reference to the Product that the user taps on


@end

@implementation ProductsTableViewController
@synthesize productsArray;
@synthesize selectedProduct;
- (void)viewWillAppear:(BOOL)animated{
    [self configureNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downloadProductsJSON];
    self.tableView.rowHeight = UITableViewAutomaticDimension; //use autolayout to determine cell height
    self.tableView.estimatedRowHeight = 100;
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
    return productsArray.count;
}

- (void)downloadProductsJSON{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager GET:@"http://wemakeapps.net/hats/products.json" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        productsArray = [Product productsWithJSONData:responseObject];
        [[self tableView]reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error.description);
    }];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
    Product *product = productsArray[indexPath.row];
    [[cell textLabel]setNumberOfLines:0]; //unlimited number of lines for the label
    [[cell textLabel]setAttributedText:[Product attributedStringForProductListWithProduct:product]];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:product.productImageURL];
    __weak UITableViewCell *weakCell = cell; //weakCell avoids retain cycle and memory leak issues
    
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:[UIImage imageNamed:@"placeholder"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {

                                       [[weakCell imageView]setImage:[Product smallThumbnailOfProductImage:image]];
                                       weakCell.imageView.contentMode = UIViewContentModeScaleAspectFit;
                                       weakCell.imageView.autoresizingMask = UIViewAutoresizingNone;
                                       [weakCell setNeedsLayout];
                                       
                                       
                                   } failure:nil];

        
    return cell;
}



- (void)configureNavigationBar{
    [[self navigationItem]setTitle:@"Select a Hat"];
      self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [[[self navigationController]navigationBar]setBarTintColor:[UIColor colorWithRed:220.0/255.0 green:36.0/255.0 blue:31.0/255.0 alpha:1.0]];
    [[[self navigationController]navigationBar]setTintColor:[UIColor whiteColor]];
    [[[self navigationController]navigationBar]setTranslucent:NO];


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedProduct = productsArray[indexPath.row];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"detailSegue"]) {
        ProductDetailTableViewController *vc = (ProductDetailTableViewController*)segue.destinationViewController;
        [vc setSelectedProduct:selectedProduct];
    }
}



@end
