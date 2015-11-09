//
//  MagicViewController.m
//  AnimationDemoSeptOtk
//
//  Created by Nikolay Shubenkov on 07/11/15.
//  Copyright © 2015 Nikolay Shubenkov. All rights reserved.
//

#import "MagicViewController.h"

@interface MagicViewController ()

@property (nonatomic, strong) CAEmitterLayer *layer;

@end

@implementation MagicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createEmmiterLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.layer.beginTime = CACurrentMediaTime();
    self.layer.lifetime  = 1;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchLocation = [[touches anyObject] locationInView:self.view];
    self.layer.emitterPosition = touchLocation;
    self.layer.renderMode = kCAEmitterLayerAdditive;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.layer.lifetime = 0;
}


- (void)createEmmiterLayer {
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    
    self.layer = layer;
    self.layer.lifetime = 0;
    layer.frame = self.view.bounds;
    
    layer.emitterPosition = self.view.center;
    layer.emitterShape = @"shpere";
    layer.emitterSize = CGSizeMake(80, 80);
    
    
    //Частицы
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.yAcceleration = 100;
    cell.scale = 0.3;
    cell.velocity = 100;
    cell.emissionRange = M_PI_2;
    cell.emissionLongitude = M_PI_2;
    cell.emissionLongitude = M_PI_2;
    
    cell.spinRange = 5;
    cell.spin = 0;
    
    cell.contents = (id) [UIImage imageNamed:@"star"].CGImage;
    cell.birthRate = 20;
    
    cell.lifetime = 15;
    
    
    layer.emitterCells = @[cell];
    
    [self.view.layer addSublayer:layer];
    
}

@end
