//
//  ClarifaiImage.m
//  ClarifaiApiDemo
//
//  Created by John Sloan on 9/1/16.
//  Copyright © 2016 Clarifai, Inc. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "ClarifaiImage.h"
#import "NSArray+Clarifai.h"

@implementation ClarifaiImage

- (instancetype)initWithScoredImageDictionary:(NSDictionary *)dict {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    
    self = [super init];
    if (self) {
        NSDictionary *image = dict[@"image"];
        self.inputID = image[@"id"];
        self.mediaURL = dict[@"url"];
        self.creationDate = [dateFormatter dateFromString:dict[@"created_at"]];
    }
    return self;
}

- (instancetype)initWithImage:(NSImage *)image {
    self = [super init];
    if (self) {
        self.image = image;
        self.mediaData = [image TIFFRepresentation];

    }
    return self;
}

- (instancetype)initWithImage:(NSImage *)image andCrop:(ClarifaiCrop *)crop {
    self = [super init];
    if (self) {
        self.image = image;
        self.mediaData = [image TIFFRepresentation];
        self.crop = crop;
    }
    return self;
}

- (instancetype)initWithImage:(NSImage *)image andConcepts:(NSArray *)concepts {
    self = [super init];
    if (self) {
        self.image = image;
        self.mediaData = [image TIFFRepresentation];
        self.concepts = [concepts map:^(id concept) {
            if ([concept isKindOfClass:[NSString class]]) {
                return [[ClarifaiConcept alloc] initWithConceptName:concept];
            } else {
                return (ClarifaiConcept *)concept;
            }
        }];
    }
    return self;
}

- (instancetype)initWithImage:(NSImage *)image crop:(ClarifaiCrop *)crop andConcepts:(NSArray *)concepts {
    self = [super init];
    if (self) {
        self.image = image;
        self.crop = crop;
        self.mediaData = [image TIFFRepresentation];
        self.concepts = [concepts map:^(id concept) {
            if ([concept isKindOfClass:[NSString class]]) {
                return [[ClarifaiConcept alloc] initWithConceptName:concept];
            } else {
                return (ClarifaiConcept *)concept;
            }
        }];
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url andCrop:(ClarifaiCrop *)crop {
    self = [super init];
    if (self) {
        self.mediaURL = url;
        self.crop = crop;
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url crop:(ClarifaiCrop *)crop andConcepts:(NSArray *)concepts {
    self = [super init];
    if (self) {
        self.mediaURL = url;
        self.crop = crop;
        self.concepts = [concepts map:^(id concept) {
            if ([concept isKindOfClass:[NSString class]]) {
                return [[ClarifaiConcept alloc] initWithConceptName:concept];
            } else {
                return (ClarifaiConcept *)concept;
            }
        }];
    }
    return self;
}

@end
