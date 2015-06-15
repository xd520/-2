//
//  NDTabBarViewController.h
//  com.nd.news
//
//  Created by zhuang0920 on 13-8-25.
//  Copyright (c) 2013年 zhuang0920. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPVSTabBarViewController : UITabBarController
{
    UIImageView *_backgroudImage;
    //    UIImageView *_selectionIndicator;
    
    NSArray     *_selectionIndicators;
    NSArray     *_itemImages;
    NSArray *_txtTitles;
    NSArray *_lines;
    UIImageView *_badgeValueImage;
}


@property (nonatomic, retain) NSArray *selectionIndicators;

- (void)setTabBarItemsTitle:(NSArray *)titles;
- (void)setTabBarItemsImage:(NSArray *)images;

- (void)setTabBarBackgroundImage:(UIImage *)image;
- (void)setSelectionIndicatorImage:(UIImage *)image;

- (void)setItemImages:(NSArray *)images;
- (void)setItemHighlightedImages:(NSArray *)highlightedImages;

- (void)removeSelectionIndicator;

- (void)showBadge;
- (void)hiddenBadge;


@end
