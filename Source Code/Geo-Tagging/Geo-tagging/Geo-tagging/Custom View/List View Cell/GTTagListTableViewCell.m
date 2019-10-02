//
//  GTTagListTableViewCell.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTTagListTableViewCell.h"

@implementation GTTagListTableViewCell
    
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
    
    -(void) configureCell: (GTTagModel *) objTagModel {
        self.lblTitle.text = [NSString stringWithFormat: @"Lat %.2f , Long %.2f",[objTagModel.latitude doubleValue],[objTagModel.longitude doubleValue]];
        self.imgTag.image = [UIImage imageWithContentsOfFile:[GTUtilty getImageFromImageName:objTagModel.strImageName]];
    }
    @end
