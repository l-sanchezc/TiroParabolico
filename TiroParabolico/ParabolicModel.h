//
//  ParabolicModel.h
//  TiroParabolico
//
//  Created by Lázaro Sánchez Campos on 08/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParabolicModel : NSObject

@property (nonatomic) float angle;
@property (nonatomic) float speed;


-(float) time;

-(float) altitudeAt:(float)seconds;
-(float) distanceAt:(float)seconds;


@end