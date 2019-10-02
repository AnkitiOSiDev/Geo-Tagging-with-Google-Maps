//
//  GTTagModel.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTTagModel.h"
#import "GTUtilty.h"

@implementation GTTagModel
    
    - (instancetype)initWithCoordinate:(CLLocationCoordinate2D )coordinate forImage:(NSString *) strPath{
        self = [super init];
        
        if(self) {
            self.strImageName = strPath;
            self.strIndex = [GTUtilty getKeyFrom:coordinate];
            self.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
            self.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        }
        return self;
    }
    
    - (instancetype)initWithEntity:(Tag *)tagEntity {
        self = [super init];
        
        // This check serves to make sure that a non-NSDictionary object
        // passed into the model class doesn't break the parsing.
        if(self && tagEntity != nil) {
            self.strImageName = tagEntity.strImageName;
            self.strIndex = tagEntity.index;
            self.latitude = tagEntity.latitude;
            self.longitude = tagEntity.longitude;
        }
        return self;
        
    }
    @end
