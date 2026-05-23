//
//  ViewController.h
//  poclink-app
//
//  Created by wyy on 2026/5/17.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *speakButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)loginButtonTapped:(UIButton *)sender;

@end

