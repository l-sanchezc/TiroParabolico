//
//  TPViewController.m
//  TiroParabolico
//
//  Created by Lázaro Sánchez Campos on 08/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "TPViewController.h"
#import "ParabolicView.h"
#import "ParabolicModel.h"

@interface TPViewController () <TiroParabolicoDataSource>

@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISlider *angleSlider;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;

@property (weak, nonatomic) IBOutlet UILabel *speedData;
@property (weak, nonatomic) IBOutlet UILabel *angleData;
@property (weak, nonatomic) IBOutlet UILabel *distanceData;

@property (weak, nonatomic) IBOutlet ParabolicView *trajectoryView;

@property (strong, nonatomic) IBOutlet ParabolicModel *parabolicModel;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGR;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGR;

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.parabolicModel = [[ParabolicModel alloc] init];
    self.trajectoryView.datasource = self;
    
    [self.speedSlider sendActionsForControlEvents:UIControlEventValueChanged];
    [self.angleSlider sendActionsForControlEvents:UIControlEventValueChanged];
    [self.distanceSlider sendActionsForControlEvents:UIControlEventValueChanged];
    
    self.trajectoryView.distance = self.distanceSlider.value;
    
    UISwipeGestureRecognizer * sru = [[UISwipeGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(processSwipe:)];
    sru.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:sru];
    
    UISwipeGestureRecognizer * srd = [[UISwipeGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(processSwipe:)];
    srd.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:srd];
    
    UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
									  initWithTarget:self
									  action:@selector(processTap:)];
    
	[tapRec setNumberOfTapsRequired:1]; // innecesario, es el defecto
	[self.view addGestureRecognizer:tapRec];
    
    UITapGestureRecognizer *tap2Rec = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(process2Tap:)];
    [tap2Rec setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:tap2Rec];
    
    [tapRec requireGestureRecognizerToFail:tap2Rec];

    
    [self.panGR requireGestureRecognizerToFail:srd];
    [self.panGR requireGestureRecognizerToFail:sru];
}

- (void)processTap:(UITapGestureRecognizer *)sender {
	 NSLog(@"Has tapeado");
    float d = self.trajectoryView.distance;
    d += 50;
    self.trajectoryView.distance = d;
    self.distanceSlider.value = d;
    int distance = d;
    self.distanceData.text = [NSString stringWithFormat:@"%i",distance,nil];
    [self.trajectoryView setNeedsDisplay];
}

- (void)process2Tap:(UITapGestureRecognizer *)sender {
    NSLog(@"Has tapeado 2 veces");
    float d = self.trajectoryView.distance;
    d -= 50;
    self.trajectoryView.distance = d;
    self.distanceSlider.value = d;
    int distance = d;
    self.distanceData.text = [NSString stringWithFormat:@"%i",distance,nil];
    [self.trajectoryView setNeedsDisplay];
}


-(void)processSwipe:(UISwipeGestureRecognizer*)sender
{
    NSLog(@"Has swipeado %d",sender.direction);
    float a = self.parabolicModel.angle;
    
    if(sender.direction == UISwipeGestureRecognizerDirectionUp) {
        a += 5.0/180 * M_PI;
    }
    else if(sender.direction == UISwipeGestureRecognizerDirectionDown) {
        a -= 5.0/180 * M_PI;
    }
    self.parabolicModel.angle = a;
    self.angleSlider.value = a;
    int angle = a/M_PI_2*90;
    self.angleData.text = [NSString stringWithFormat:@"%i",angle,nil];
    [self.trajectoryView setNeedsDisplay];
}

- (IBAction)processPan:(UIPanGestureRecognizer *)sender {
    NSLog(@"PAN PAN PAN");
    float s = self.parabolicModel.speed;
    s += [sender translationInView:sender.view].x;
    self.parabolicModel.speed = s;
    self.speedSlider.value = s;
    int speed = s;
    self.speedData.text = [NSString stringWithFormat:@"%i",speed,nil];
    [sender setTranslation:CGPointZero inView:sender.view];
    [self.trajectoryView setNeedsDisplay];
}


-(void)viewWillLayoutSubviews {
    [self.trajectoryView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Acciones
- (IBAction)speedChange:(UISlider *)sender {
    NSLog(@"velodidad = %f",sender.value);
    self.speedData.text = [@((int)sender.value) description];
    [self.trajectoryView setNeedsDisplay];
    self.parabolicModel.speed = sender.value;
}

- (IBAction)angleChange:(UISlider *)sender {
    self.angleData.text = [@((int)(sender.value/M_PI_2*90)) description];
    [self.trajectoryView setNeedsDisplay];
    self.parabolicModel.angle = sender.value;
}

- (IBAction)distanceChanhe:(UISlider *)sender {
    self.distanceData.text = [@((int)sender.value) description];
    [self.trajectoryView setNeedsDisplay];
    self.trajectoryView.distance = sender.value;
}



#pragma mark - TiroParabolico Data Source
-(Position) positionAt:(float)seconds{
    Position pos;
    pos.altitude = [self.parabolicModel altitudeAt:seconds];
    pos.distance = [self.parabolicModel distanceAt:seconds];
    return pos;
}

-(float) initialTime{
    return 0;
}

-(float) endTime{
    return [self.parabolicModel time];
}



@end
