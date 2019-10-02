//
//  GTTagListViewController.h
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GTTagListViewControllerDelegate <NSObject>
- (void)showMarkerForLatitude:(NSString *)strLatitude longitude:(NSString *)strLongitude;
  @end

@interface GTTagListViewController : UIViewController
@property (nonatomic, weak) id <GTTagListViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *arrTags ;
@property int index;
@end

NS_ASSUME_NONNULL_END
