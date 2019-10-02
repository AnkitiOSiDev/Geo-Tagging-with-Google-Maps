//
//  Tag+CoreDataProperties.m
//  
//
//  Created by Ankit on 24/02/19.
//
//

#import "Tag+CoreDataProperties.h"

@implementation Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
}

@dynamic strImageName;
@dynamic index;
@dynamic latitude;
@dynamic longitude;

@end
