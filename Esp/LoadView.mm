#import <UIKit/UIKit.h>
#include "Includes.h"
#import "menuIcon.h"
#import "Esp/Obfuscate.h"

#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^

@interface MenuLoad()
@property (nonatomic, strong) ImGuiDrawView *vna;
- (ImGuiDrawView*)GetImGuiView;
@end

static MenuLoad *extraInfo;

UIButton* InvisibleMenuButton;
UIButton* VisibleMenuButton;
MenuInteraction* menuTouchView;
UITextField* hideRecordTextfield;
UIView* hideRecordView;

@implementation MenuInteraction

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[extraInfo GetImGuiView] updateIOWithTouchEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[extraInfo GetImGuiView] updateIOWithTouchEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[extraInfo GetImGuiView] updateIOWithTouchEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[extraInfo GetImGuiView] updateIOWithTouchEvent:event];
}

@end

@implementation MenuLoad

- (ImGuiDrawView*)GetImGuiView {
    return _vna;
}

#pragma mark - Launch

static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info)
{
    timer(3) {
        extraInfo = [MenuLoad new];
        [extraInfo initTapGes];
    });
}

__attribute__((constructor)) static void initialize()
{
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetLocalCenter(),
        NULL,
        &didFinishLaunching,
        (CFStringRef)UIApplicationDidFinishLaunchingNotification,
        NULL,
        CFNotificationSuspensionBehaviorDrop
    );
}

#pragma mark - UI

- (void)initTapGes
{
    UIView *mainView = [UIApplication sharedApplication].windows[0].rootViewController.view;

    hideRecordTextfield = [[UITextField alloc] init];
    hideRecordView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    hideRecordView.backgroundColor = UIColor.clearColor;

    hideRecordTextfield.secureTextEntry = YES;
    [hideRecordView addSubview:hideRecordTextfield];

    CALayer *layer = hideRecordTextfield.layer;
    if ([layer.sublayers.firstObject.delegate isKindOfClass:[UIView class]]) {
        hideRecordView = (UIView *)layer.sublayers.firstObject.delegate;
    }

    [[UIApplication sharedApplication].keyWindow addSubview:hideRecordView];

    if (!_vna) {
        _vna = [[ImGuiDrawView alloc] init];
    }

    [ImGuiDrawView showChange:false];
    [hideRecordView addSubview:_vna.view];

    menuTouchView = [[MenuInteraction alloc] initWithFrame:mainView.frame];
    [mainView addSubview:menuTouchView];

    NSData *data = [[NSData alloc] initWithBase64EncodedString:menuIcon options:0];
    UIImage *menuIconImage = [UIImage imageWithData:data];

    InvisibleMenuButton = [UIButton buttonWithType:UIButtonTypeSystem];
    InvisibleMenuButton.frame = CGRectMake(10, 10, 50, 50);
    InvisibleMenuButton.backgroundColor = UIColor.clearColor;
    [InvisibleMenuButton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchDragInside];
    [mainView addSubview:InvisibleMenuButton];

    VisibleMenuButton = [UIButton buttonWithType:UIButtonTypeSystem];
    VisibleMenuButton.frame = CGRectMake(10, 10, 50, 50);
    VisibleMenuButton.layer.cornerRadius = 25;
    [VisibleMenuButton setBackgroundImage:menuIconImage forState:UIControlStateNormal];
    [hideRecordView addSubview:VisibleMenuButton];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    gesture.numberOfTapsRequired = 2;
    gesture.numberOfTouchesRequired = 3;
    [mainView addGestureRecognizer:gesture];
}

#pragma mark - Menu toggle

- (void)showMenu:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [ImGuiDrawView showChange:![ImGuiDrawView isMenuShowing]];
    }
}

#pragma mark - Drag

- (void)buttonDragged:(UIButton *)button withEvent:(UIEvent *)event
{
    UITouch *touch = [[event touchesForView:button] anyObject];

    CGPoint prev = [touch previousLocationInView:button];
    CGPoint curr = [touch locationInView:button];

    CGFloat dx = curr.x - prev.x;
    CGFloat dy = curr.y - prev.y;

    button.center = CGPointMake(button.center.x + dx, button.center.y + dy);

    VisibleMenuButton.center = button.center;
    VisibleMenuButton.frame = button.frame;
}

@end