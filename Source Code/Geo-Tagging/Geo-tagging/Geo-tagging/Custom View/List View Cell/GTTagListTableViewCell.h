//
//  GTTagListTableViewCell.h
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTTagModel.h"
#import "GTUtilty.h"

NS_ASSUME_NONNULL_BEGIN

@interface GTTagListTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UIImageView *imgTag;
    @property (weak, nonatomic) IBOutlet UILabel *lblTitle;
    -(void) configureCell: (GTTagModel *) objTagModel ;
@end

NS_ASSUME_NONNULL_END
