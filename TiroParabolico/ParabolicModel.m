//
//  ParabolicModel.m
//  TiroParabolico
//
//  Created by Lázaro Sánchez Campos on 8/11/13.
//  Copyright (c) 2013 g012 DIT UPM. All rights reserved.
//

#import "ParabolicModel.h"

#define GRAVITY 9.80665

@implementation ParabolicModel

-(float) speedX0 {
    return self.speed * cos(self.angle);
}

-(float) speedY0 {
    return self.speed *sin(self.angle);
}

-(float) time {
    return 2 * [self speedY0]/GRAVITY;
}

-(float) altitudeAt:(float)seconds {
    return [self speedY0] * seconds -0.5 * GRAVITY * seconds * seconds;
}

-(float) distanceAt:(float)seconds {
    return [self speedX0] * seconds;
}

@end
