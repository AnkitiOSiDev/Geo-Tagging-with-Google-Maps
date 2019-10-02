//
//  GTDatabaseManager.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTDatabaseManager.h"
#import "GTUserDefaults.h"
#import "GTTagModel.h"

@implementation GTDatabaseManager{
    //GTUserDefaults *udManager ; // If we want to use default to store tags
    GTCoreDataManager *coreDataManager;
}
    
    - (id)init {
        if (self = [super init]) {
            coreDataManager = [[GTCoreDataManager alloc] init];
        }
        return self;
    }
    
    - (void) saveTag:(GTTagModel *)tagModel {
        [coreDataManager insertData:tagModel];
    }
    
    -(GTTagModel *) getTagFor:(CLLocationCoordinate2D )coordinate{
        GTTagModel *tagModel = [coreDataManager getTagForIndex:[GTUtilty getKeyFrom:coordinate]];
        return tagModel;
    }
    
    -(NSArray*) getAllTags{
        return [coreDataManager getAllTags];
    }
    
    
    @end
