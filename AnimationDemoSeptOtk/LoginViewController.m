//
//  LoginViewController.m
//  AnimationDemoSeptOtk
//
//  Created by Nikolay Shubenkov on 07/11/15.
//  Copyright © 2015 Nikolay Shubenkov. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginCenterConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordCenterConstraint;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1LeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2LeftSpace;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFields];
    self.loginButton.alpha = 0;
}

- (void)setupFields {
    [self configureTextField:self.loginField];
    [self configureTextField:self.passwordField];
    self.loginCenterConstraint.constant = 400;
    self.passwordCenterConstraint.constant = 400;
}

- (void)configureTextField:(UITextField *)field {
    field.alpha = 0;
    //Сделаем закругление
    field.layer.cornerRadius = CGRectGetHeight(field.frame) / 2;
    
    //Цвет окантовки
    field.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.2].CGColor;
    field.layer.borderWidth = 5;
    
    field.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    
}

//Самое место для анимаций
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animateBackground];
    [self animateFieldsAppearing];
}
//Отображение фона
- (void)animateBackground {
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.view.backgroundColor = [UIColor blueColor];
                     }];
}
//Отображение полей
- (void)animateFieldsAppearing {
    self.loginCenterConstraint.constant = 0;

    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.loginField.alpha = 1;
                         [self.view layoutIfNeeded];
                         
                     } completion:^(BOOL finished) {
                         self.passwordField.alpha = 1;
                         self.passwordCenterConstraint.constant = 0;
                         [UIView animateWithDuration:0.5
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              [self.view layoutIfNeeded];
                                          } completion:nil];
                         
                     }];
    
}

- (IBAction)moveToRight:(id)sender {
    [self animateViewsToPoint:200];
}
- (IBAction)moveLeft:(id)sender {
    [self animateViewsToPoint:0];
}

- (void)animateViewsToPoint:(CGFloat)point {
    self.view1LeftSpace.constant = point;
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:nil];
    
    self.view2LeftSpace.constant = point;
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.view layoutIfNeeded];
                     } completion:nil];
}


@end
