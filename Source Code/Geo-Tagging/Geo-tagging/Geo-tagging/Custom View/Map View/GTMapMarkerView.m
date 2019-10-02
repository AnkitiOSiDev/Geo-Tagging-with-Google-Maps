//
//  GTMapMarkerView.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTMapMarkerView.h"

@implementation GTMapMarkerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
    
- (void)awakeFromNib{
    [super awakeFromNib];
    self.imgLogo.transform = CGAffineTransformMakeRotation(-.08);
    self.backgroundColor = [UIColor grayColor];
    self.viewParent.layer.cornerRadius = 3.0;
    self.viewParent.layer.borderWidth = 1.0;
    self.viewParent.layer.borderColor = [UIColor blackColor].CGColor;
    self.viewParent.clipsToBounds = TRUE;
}

@end
