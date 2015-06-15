//
//  NDTabBarViewController.m
//  com.nd.news
//
//  Created by zhuang0920 on 13-8-25.
//  Copyright (c) 2013年 zhuang0920. All rights reserved.
//

#import "CPVSTabBarViewController.h"
#import "ColorUtil.h"

@interface CPVSTabBarViewController ()

- (void)removeSelectionIndicator:(UITabBarController *)tabBarController;

@end

@implementation CPVSTabBarViewController


@synthesize selectionIndicators = _selectionIndicators;

- (id)init {
    self = [super init];
    if (self) {
		[self addObserver:self
               forKeyPath:@"selectedViewController"
                  options:NSKeyValueObservingOptionInitial
                  context:nil];
        
        if (_backgroudImage == nil) {
            _backgroudImage = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
            
           
            //_backgroudImage.image =[UIImage imageWithColor:[UIColor whiteColor]];CGRectMake(0, ScreenHeight - 49*_sizeScaleY , 320*_sizeScaleX, 49*_sizeScaleY)
            _backgroudImage.contentMode = UIViewContentModeCenter;
            _backgroudImage.backgroundColor = [ColorUtil colorWithHexString:@"eeeeee"];
            [self.tabBar addSubview:_backgroudImage];
        }
        
        if (_badgeValueImage == nil) {
            _badgeValueImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"number_warning.png"]];
            _badgeValueImage.hidden = YES;
            [self.tabBar addSubview:_badgeValueImage];
        }        
//        if (_selectionIndicator == nil) {
//            _selectionIndicator = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
//            _selectionIndicator.contentMode = UIViewContentModeCenter;
//            _selectionIndicator.hidden = YES;
//            [self.tabBar addSubview:_selectionIndicator];
//        }
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   
     NSLog(@"%f  %f",self.tabBar.frame.size.height,self.tabBar.frame.origin.y);
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"selectedViewController"];
    [_backgroudImage release];
    [_selectionIndicators release];
    [_itemImages release];
    [_badgeValueImage release];
    [super dealloc];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (object == self) {
        NSInteger index = self.selectedIndex;
        [self removeSelectionIndicator:self];
        
        for (int i = 0; i < _itemImages.count; ++i) {
            UIImageView *currentItemImage = [_itemImages objectAtIndex:i];
//            UILabel *line=_lines[i];
            if (i == index) {
                currentItemImage.highlighted = YES;
//                [line setBackgroundColor:[UIColor colorWithHexString:@"#1b89e6"]];
            } else {
                currentItemImage.highlighted = NO;
//                [line setBackgroundColor:[UIColor clearColor]];
            }
        }
    }
}

#pragma mark - Private Method

- (void)removeSelectionIndicator
{
    [self removeSelectionIndicator:self];
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)removeSelectionIndicator:(UITabBarController *)tabBarController {
    for (UIView *subview in tabBarController.tabBar.subviews) {
        if ([NSStringFromClass([subview class])
             isEqualToString:@"UITabBarButton"]) {
            for (UIView *currentView in subview.subviews) {
                if ([NSStringFromClass([currentView class])
                     isEqualToString:@"UITabBarSelectionIndicatorView"]) {
                    [currentView removeFromSuperview];
                    break;
                }
            }
        }
    }
}

#pragma mark - OverRide Super Class
- (void)setViewControllers:(NSArray *)viewControllers
{
    [super setViewControllers:viewControllers];
    
    NSMutableArray *itemImages = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *txtTitles = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < viewControllers.count; ++i) {
        UIImageView *itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.tabBar.frame.size.width / viewControllers.count * i, 0, self.tabBar.frame.size.width / viewControllers.count,self.tabBar.frame.size.height)];
        itemImageView.contentMode = UIViewContentModeCenter;
        itemImageView.image = nil;
        [itemImages addObject:itemImageView];
        UILabel *txtTitle=[[UILabel alloc] initWithFrame:CGRectMake(self.tabBar.frame.size.width / viewControllers.count * i, 0, self.tabBar.frame.size.width / viewControllers.count, 18)];
        [txtTitles addObject:txtTitle];
        [txtTitle release];
        [itemImageView release];
    }
    
    if (_itemImages)
    {
        for (UIImageView *imageView in _itemImages) {
            [imageView removeFromSuperview];
        }
        [_itemImages release];
        _itemImages = nil;
    }
    if (_txtTitles) {
        for (UILabel *txtTitle in _txtTitles) {
            [txtTitle removeFromSuperview];
        }
        _txtTitles=nil;
    }
    _itemImages = [[NSArray alloc] initWithArray:itemImages];
    _txtTitles=[[NSArray alloc] initWithArray:txtTitles];
    [itemImages release];
    [txtTitles release];
    NSMutableArray *lines=[[NSMutableArray alloc] initWithCapacity:0];
    for (UIImageView *imageView in _itemImages) {
//        UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 2)];
//        [line setBackgroundColor:[UIColor clearColor]];

//        if ([_itemImages indexOfObject:imageView] == 0) {
//            imageView.highlighted = YES;
////            [line setBackgroundColor:[UIColor colorWithHexString:@"#1b89e6"]];
//        }
//                [imageView addSubview:line];
//         [lines addObject:line];
//        [line release];
        [self.tabBar addSubview:imageView];
        }
//    _lines=[[NSArray alloc] initWithArray:lines];
    [lines release];
}

#pragma mark - Setter for Items Title
/*
- (void)setTabBarItemsTitle:(NSArray *)titles
{
    for (int i = 0; i < self.tabBar.items.count && i < titles.count; ++i)
    {
        UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:i];
        tabBarItem.title = [titles objectAtIndex:i];
    }
}
*/
#pragma mark - Setter for Items Image
/*
- (void)setTabBarItemsImage:(NSArray *)images
{
    for (int i = 0; i < self.tabBar.items.count && i < images.count; ++i) {
        UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:i];
        tabBarItem.image = [images objectAtIndex:i];
    }
}
*/
- (void)setTabBarBackgroundImage:(UIImage *)image
{
    _backgroudImage.image = image;
}

- (void)setSelectionIndicatorImage:(UIImage *)image
{
//    _selectionIndicator.image = image;
//    _selectionIndicator.frame = CGRectMake(_selectionIndicator.frame.origin.x,
//                                           _selectionIndicator.frame.origin.y,
//                                           self.tabBar.frame.size.width / self.tabBar.items.count,
//                                           _selectionIndicator.frame.size.height);
}

- (void)setItemImages:(NSArray *)images
{
    for (int i = 0; i < _itemImages.count && i < images.count; ++i) {
        UIImageView *imageView = [_itemImages objectAtIndex:i];
        imageView.image = [images objectAtIndex:i];
    }
}

- (void)setItemHighlightedImages:(NSArray *)highlightedImages
{
    for (int i = 0; i < _itemImages.count && i < highlightedImages.count; ++i) {
        UIImageView *imageView = [_itemImages objectAtIndex:i];
        imageView.highlightedImage = [highlightedImages objectAtIndex:i];
        if (i == 0) {
            imageView.highlighted = YES;
        }
    }
}

- (void)showBadge
{
    NSInteger imageCount = _itemImages.count;
    CGFloat cellWidth = self.tabBar.frame.size.width / imageCount;
    CGFloat xOffest = self.tabBar.frame.size.width - cellWidth/2.0 + 8.0f;
    _badgeValueImage.frame = CGRectMake( xOffest, 8.0f, 8.0f, 8.0f);
    _badgeValueImage.hidden = NO;
    [_backgroudImage setBackgroundColor:[ColorUtil colorWithHexString:@"eeeeee"]];
}

- (void)hiddenBadge
{
    _badgeValueImage.hidden = YES;
}
@end
