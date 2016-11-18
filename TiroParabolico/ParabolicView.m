//
//  ParabolicView.m
//  TiroParabolico
//
//  Created by Lázaro Sánchez Campos on 08/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "ParabolicView.h"
#define HMETERS 1000

@implementation ParabolicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setDistance:(float)distance{
    _distance=distance;
    [self setNeedsDisplay];
}


-(float) meters2Xpixels:(float)meters
{
    float w = self.bounds.size.width;
    return meters/HMETERS*w;
}

-(float) meters2Ypixels:(float)meters
{
    float w = self.bounds.size.width;
    float h = self.bounds.size.height;
    return h-meters/HMETERS*w;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    float distance0 = self.distance;
    
    float initialTime = [self.datasource initialTime];
    float endTime = [self.datasource endTime];
    
    Position pos = [self.datasource positionAt:initialTime];
    float x = [self meters2Xpixels:pos.distance];
    float y = [self meters2Ypixels:pos.altitude];
    float xobjetivo = [self meters2Xpixels:(distance0)];
    
    UIBezierPath *path =[UIBezierPath bezierPath];
    UIBezierPath *path1 =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(xobjetivo,self.bounds.size.height-20,20,20) cornerRadius:20];
    [path moveToPoint:CGPointMake(x,y)];
    
    for(float t=initialTime; t<= endTime; t+=0.01) {
        pos = [self.datasource positionAt:t];
        float x = [self meters2Xpixels:pos.distance];
        float y =[self meters2Ypixels:pos.altitude];
        [path addLineToPoint:(CGPointMake(x,y))];
    }
    
    [[UIColor redColor] set];
    path.lineWidth=3;
    [path stroke];
    
    [[UIColor cyanColor] setFill];
    path1.lineWidth=3;
    [path1 fill];
    [path1 stroke];
}

@end
