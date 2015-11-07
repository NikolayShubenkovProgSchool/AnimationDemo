//
//  LoginViewController.m
//  AnimationDemoSeptOtk
//
//  Created by Nikolay Shubenkov on 07/11/15.
//  Copyright © 2015 Nikolay Shubenkov. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginCenterConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordCenterConstraint;

@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1LeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2LeftSpace;
@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *springView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFields];
    self.loginButton.alpha = 0;
    [self createGradient];
    [self createTopGradient];
    [self setupButton];
}

- (void)setupButton {
    self.loginButton.layer.cornerRadius = CGRectGetHeight(self.loginButton.frame) / 2;
    self.loginButton.backgroundColor = [UIColor orangeColor];
    self.loginButton.layer.borderWidth = 5;
    self.loginButton.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
}

- (void)createTopGradient {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.imageView.bounds;
    layer.colors = @[[UIColor yellowColor],[UIColor clearColor]];
    layer.startPoint = CGPointMake(0.5,0);
    layer.endPoint   = CGPointMake(0.5, 0.5);
    
    layer.locations = @[@0, @0.5];
}

- (void)createGradient {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.gradientView.bounds;
    
    UIColor *color1 = [UIColor orangeColor];
    UIColor *color2 = [UIColor purpleColor];
    UIColor *color3 = [UIColor yellowColor];
    
    //опорные точки на линии
    layer.locations = @[
                         @0.2,
                         @0.6,
                         @0.9
                       ];
    
    layer.colors = @[(id) color1.CGColor,(id)color2.CGColor,(id)color3.CGColor];
    
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint   = CGPointMake(1, 1);
    
    [self.gradientView.layer addSublayer:layer];
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
    field.layer.borderColor = [[UIColor greenColor] colorWithAlphaComponent:0.2].CGColor;
    field.layer.borderWidth = 5;
    
    field.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    
    UIColor *textColor = [UIColor colorWithRed:127/255.0
                                         green:255/255.0
                                          blue:212/255.0
                                         alpha:1];
    field.textColor = textColor;
    field.attributedPlaceholder = [[NSAttributedString alloc]initWithString:field.placeholder
                                                                 attributes:@{NSForegroundColorAttributeName : [textColor colorWithAlphaComponent:0.6]}];
    field.tintColor = textColor;
    field.delegate  = self;
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
                         self.view.backgroundColor = [UIColor colorWithRed:127/255.0
                                                                     green:255/255.0
                                                                      blue:212/255.0
                                                                     alpha:1];
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
- (IBAction)showMeTheSpring:(id)sender {
    
    static BOOL enlargeView = YES;
    [UIView animateWithDuration:2
                          delay:0
         usingSpringWithDamping:0.3
          initialSpringVelocity:5
                        options:0
                     animations:^{
                         CGFloat width = enlargeView == YES ? 150 : 20;
                         self.springView.constant = width;
                         [self.view layoutIfNeeded];
                         enlargeView = !enlargeView;
                     }
                     completion:nil];
}

- (IBAction)loginPressed:(UIButton *)sender {
    if ([self.passwordField.text isEqualToString:@"123456"]){
        //покажем новый экран с супре анимацией
        return;
    }
    [self shakePasswordField];
}

- (void)shakePasswordField {
    [UIView animateKeyframesWithDuration:1.5
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  //Ведем вправо
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    self.passwordCenterConstraint.constant = 40;
                                                                    [self.view layoutIfNeeded];
                                                                }];
                                  //Ведем влево
                                  [UIView addKeyframeWithRelativeStartTime:0.3
                                                          relativeDuration:0.4
                                                                animations:^{
                                                                    self.passwordCenterConstraint.constant = -30;
                                                                    [self.view layoutIfNeeded];
                                                                }];
                                  //Опять вправо
                                  [UIView addKeyframeWithRelativeStartTime:0.6
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    self.passwordCenterConstraint.constant = 10;
                                                                    [self.view layoutIfNeeded];
                                                                }];
                                  //Закончили упражнение
                                  [UIView addKeyframeWithRelativeStartTime:0.8
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    self.passwordCenterConstraint.constant = 0;
                                                                    [self.view layoutIfNeeded];
                                                                }];
                              }
                              completion:nil];
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

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *result = [textField.text stringByReplacingCharactersInRange:range
                                                              withString:string];
    NSString *loginFieldText;
    NSString *passwordFieldText;
    if (textField == self.loginField){
        loginFieldText = result;
        passwordFieldText = self.passwordField.text;
    }
    else {
        loginFieldText = self.loginField.text;
        passwordFieldText = result;
    }
    
    [self updateButtonForLoginText:loginFieldText
                          password:passwordFieldText];
    
    return YES;
}

- (void)updateButtonForLoginText:(NSString *)login password:(NSString *)password {
    //если ввели логин и пароль длиннее 6 символов, покажем кнопку
    BOOL show = login.length > 0 && password.length > 6;
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.loginButton.alpha = show ? 1 : 0;
                     } completion:nil];
}

@end
