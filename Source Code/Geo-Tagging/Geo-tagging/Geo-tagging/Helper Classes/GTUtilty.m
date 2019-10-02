//
//  GTUtilty.m
//  Geo-tagging
//
//  Created by Ankit on 24/02/19.
//  Copyright © 2019 Ankit. All rights reserved.
//

#import "GTUtilty.h"


@implementation GTUtilty
    
    + (NSString*)saveImage:(UIImage*)image imageName:(NSString*)strImageName
    {
        strImageName =  [strImageName stringByReplacingOccurrencesOfString:@"." withString:@""];
        strImageName =  [strImageName stringByAppendingString:@".jpg"];
        NSData *imageData = UIImageJPEGRepresentation(image,1.0); //convert image into .jpeg format.
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:
                              [NSString stringWithFormat:@"%@", strImageName]];
        [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
        return strImageName;
    }
    
    +(NSString *) getKeyFrom:(CLLocationCoordinate2D )coordinate {
        return [NSString stringWithFormat: @"Lat%f , Long %f",coordinate.latitude,coordinate.longitude];
    }
    
    + (NSString*)getImageFromImageName:(NSString *)strImageName
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:strImageName];
        return getImagePath;
    }
    @end
