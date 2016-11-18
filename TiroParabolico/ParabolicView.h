//
//  ParabolicView.h
//  TiroParabolico
//
//  Created by Lázaro Sánchez Campos on 08/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.

//

#import <UIKit/UIKit.h>


typedef struct {
    float distance;
    float altitude;
} Position;


@protocol TiroParabolicoDataSource

-(float) initialTime;
-(float) endTime;

-(Position) positionAt:(float)seconds;

@end

@interface ParabolicView : UIView

@property (nonatomic, weak) id<TiroParabolicoDataSource> datasource;

@property(nonatomic) float distance;

@end