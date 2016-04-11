//
//  PrinterViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "PrinterViewController.h"

#import "AppDelegate.h"

#import "Communication.h"

#import "PrinterFunctions.h"

#import "ILocalizeReceipts.h"

@interface PrinterViewController ()

@end

@implementation PrinterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    static NSString *CellIdentifier = @"UITableViewCellStyleValue1";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
        
        switch (indexPath.row) {
            default :
//          case 0  :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Receipt",                localizeReceipts.languageCode, localizeReceipts.paperSize];
                break;
            case 1 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Text Receipt (UTF8)",         localizeReceipts.languageCode, localizeReceipts.paperSize];
                break;
            case 2 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt",              localizeReceipts.languageCode, localizeReceipts.paperSize];
                break;
            case 3 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt (Both Scale)", localizeReceipts.languageCode, localizeReceipts.scalePaperSize];
                break;
            case 4 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ Raster Receipt (Scale)",      localizeReceipts.languageCode, localizeReceipts.scalePaperSize];
                break;
            case 5 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ Raster Coupon",                  localizeReceipts.languageCode];
                break;
            case 6 :
                cell.textLabel.text = [NSString stringWithFormat:@"%@ Raster Coupon (Rotation90)",     localizeReceipts.languageCode];
                break;
        }
        
        cell.detailTextLabel.text = @"";
        
        cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        
//      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        BOOL userInteractionEnabled = YES;
        
        StarIoExtEmulation emulation = [AppDelegate getEmulation];
        
        if (emulation == StarIoExtEmulationStarGraphic) {
            if (indexPath.row == 0 ||     // Text Receipt
                indexPath.row == 1) {     // Text Receipt (UTF8)
                userInteractionEnabled = NO;
            }
        }
        
        if (emulation == StarIoExtEmulationEscPos ||
            emulation == StarIoExtEmulationEscPosMobile) {
            if (indexPath.row == 1) {     // Text Receipt (UTF8)
                userInteractionEnabled = NO;
            }
        }
        
        if (emulation == StarIoExtEmulationStarDotImpact) {
            if (indexPath.row == 2 ||     // Raster Receipt
                indexPath.row == 3 ||     // Raster Receipt (Both Scale)
                indexPath.row == 4) {     // Raster Receipt (Scale)
                userInteractionEnabled = NO;
            }
        }
        
        if (userInteractionEnabled == YES) {
            cell.      textLabel.alpha = 1.0;
            cell.detailTextLabel.alpha = 1.0;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.userInteractionEnabled = YES;
        }
        else {
            cell.      textLabel.alpha = 0.3;
            cell.detailTextLabel.alpha = 0.3;
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            cell.userInteractionEnabled = NO;
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = @"";
    
    if (section == 0) {
        title = @"Like a StarIO-SDK Sample";
    }
    else {
        title = @"StarIoExtManager Sample";
    }
    
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        NSData *commands = nil;
        
        StarIoExtEmulation emulation = [AppDelegate getEmulation];
        
        NSInteger width = [AppDelegate getSelectedPaperSize];
        
        ILocalizeReceipts *localizeReceipts = [ILocalizeReceipts createLocalizeReceipts:[AppDelegate getSelectedLanguage] paperSizeIndex:[AppDelegate getSelectedPaperSize]];
        
        switch (indexPath.row) {
            default :
//          case 0  :
                commands = [PrinterFunctions createTextReceiptData:emulation localizeReceipts:localizeReceipts utf8:NO];
                break;
            case 1 :
                commands = [PrinterFunctions createTextReceiptData:emulation localizeReceipts:localizeReceipts utf8:YES];
                break;
            case 2 :
                commands = [PrinterFunctions createRasterReceiptData:emulation localizeReceipts:localizeReceipts];
                break;
            case 3 :
                commands = [PrinterFunctions createScaleRasterReceiptData:emulation localizeReceipts:localizeReceipts width:width bothScale:YES];
                break;
            case 4 :
                commands = [PrinterFunctions createScaleRasterReceiptData:emulation localizeReceipts:localizeReceipts width:width bothScale:NO];
                break;
            case 5 :
                commands = [PrinterFunctions createCouponData:emulation localizeReceipts:localizeReceipts width:width rotation:SCBBitmapConverterRotationNormal];
                break;
            case 6 :
                commands = [PrinterFunctions createCouponData:emulation localizeReceipts:localizeReceipts width:width rotation:SCBBitmapConverterRotationRight90];
                break;
        }
        
        self.blind = YES;
        
        [Communication sendCommands:commands portName:[AppDelegate getPortName] portSettings:[AppDelegate getPortSettings] timeout:10000];     // 10000mS!!!
        
        self.blind = NO;
    }
    else {
        [AppDelegate setSelectedIndex:indexPath.row];
        
        [self performSegueWithIdentifier:@"PushPrinterExtViewController" sender:nil];
    }
}

@end
