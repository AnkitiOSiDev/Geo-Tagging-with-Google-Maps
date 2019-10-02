//
//  GTMapMarkerView.h
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTMapMarkerView : UIView
    @property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
    @property (weak, nonatomic) IBOutlet UILabel *lblTitle;
    @property (weak, nonatomic) IBOutlet UIView *viewParent;
    
@end

NS_ASSUME_NONNULL_END
