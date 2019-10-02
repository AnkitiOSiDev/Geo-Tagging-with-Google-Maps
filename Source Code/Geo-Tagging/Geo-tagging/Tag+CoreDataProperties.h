//
//  Tag+CoreDataProperties.h
//  
//
//  Created by Ankit on 24/02/19.
//
//

#import "Tag+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *strImageName;
@property (nullable, nonatomic, copy) NSString *index;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;

@end

NS_ASSUME_NONNULL_END
