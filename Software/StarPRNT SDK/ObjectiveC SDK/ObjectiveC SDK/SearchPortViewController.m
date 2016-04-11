//
//  SearchPortViewController.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright (c) 2015年 Star Micronics. All rights reserved.
//

#import "SearchPortViewController.h"

#import "AppDelegate.h"

#import "ModelCapability.h"

#import <StarIO/SMPort.h>

typedef NS_ENUM(NSInteger, CellParamIndex) {
    CellParamIndexPortName = 0,
    CellParamIndexModelName,
    CellParamIndexMacAddress
};

typedef NS_ENUM(NSInteger, AlertViewIndex) {
    AlertViewIndexRefreshPort = 0,
    AlertViewIndexConfirm0,
    AlertViewIndexConfirm1
};

@interface SearchPortViewController ()

@property (nonatomic) NSMutableArray *cellArray;

@property (nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic) BOOL didAppear;

- (void)refreshPortInfo;

@end

@implementation SearchPortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self appendRefreshButton:@selector(refreshPortInfo)];
    
    _cellArray = [[NSMutableArray alloc] init];
    
    _selectedIndexPath = nil;
    
    _didAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_didAppear == NO) {
        [self refreshPortInfo];
        
        _didAppear = YES;
    }
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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return _cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCellStyleSubtitle";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (cell != nil) {
        NSArray *cellParam = _cellArray[indexPath.row];
        
//      cell.      textLabel.text = cellParam[CellParamIndexPortName];
        cell.      textLabel.text = cellParam[CellParamIndexModelName];
//      cell.detailTextLabel.text = cellParam[CellParamIndexModelName];
        
        if ([cellParam[CellParamIndexMacAddress] isEqualToString:@""]) {
            cell.detailTextLabel.text = cellParam[CellParamIndexPortName];
        }
        else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", cellParam[CellParamIndexPortName], cellParam[CellParamIndexMacAddress]];
        }
        
        cell.      textLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if (_selectedIndexPath != nil) {
            if ([indexPath compare:_selectedIndexPath] == NSOrderedSame) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"List";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell;
    
    if (_selectedIndexPath != nil) {
        cell = [tableView cellForRowAtIndexPath:_selectedIndexPath];
        
        if (cell != nil) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    _selectedIndexPath = indexPath;
    
    NSArray *cellParam = _cellArray[_selectedIndexPath.row];
    
//  NSString *portName   = cellParam[CellParamIndexPortName];
    NSString *modelName  = cellParam[CellParamIndexModelName];
//  NSString *macAddress = cellParam[CellParamIndexMacAddress];
    
    if (false) {     // Ex1. Direct Setting.
//      NSString           *portSettings = @"";
//      NSString           *portSettings = @"mini";
//      NSString           *portSettings = @"escpos";
//      NSString           *portSettings = @"Portable";
//
//      StarIoExtEmulation  emulation = StarIoExtEmulationStarPRNT;
//      StarIoExtEmulation  emulation = StarIoExtEmulationStarLine;
//      StarIoExtEmulation  emulation = StarIoExtEmulationStarGraphic;
//      StarIoExtEmulation  emulation = StarIoExtEmulationEscPos;
//      StarIoExtEmulation  emulation = StarIoExtEmulationEscPosMobile;
//      StarIoExtEmulation  emulation = StarIoExtEmulationStarDotImpact;
//
//      [AppDelegate setPortName    :portName];
//      [AppDelegate setModelName   :modelName];
//      [AppDelegate setMacAddress  :macAddress];
//      [AppDelegate setPortSettings:portSettings];
//      [AppDelegate setEmulation   :emulation];
//
//      [self.navigationController popViewControllerAnimated:YES];
    }
    else if (false) {     // Ex2. Direct Setting.
//      ModelIndex modelIndex = ModelIndexMPOP;
//      ModelIndex modelIndex = ModelIndexFVP10;
//      ModelIndex modelIndex = ModelIndexTSP100;
//      ModelIndex modelIndex = ModelIndexTSP650II;
//      ModelIndex modelIndex = ModelIndexTSP700II;
//      ModelIndex modelIndex = ModelIndexTSP800II;
//      ModelIndex modelIndex = ModelIndexSM_S210I;
//      ModelIndex modelIndex = ModelIndexSM_S220I;
//      ModelIndex modelIndex = ModelIndexSM_S230I;
//      ModelIndex modelIndex = ModelIndexSM_T300I;
//      ModelIndex modelIndex = ModelIndexSM_T400I;
//      ModelIndex modelIndex = ModelIndexBSC10;
//      ModelIndex modelIndex = ModelIndexSM_S210I_StarPRNT;
//      ModelIndex modelIndex = ModelIndexSM_S220I_StarPRNT;
//      ModelIndex modelIndex = ModelIndexSM_S230I_StarPRNT;
//      ModelIndex modelIndex = ModelIndexSM_T300I_StarPRNT;
//      ModelIndex modelIndex = ModelIndexSM_T400I_StarPRNT;
//      ModelIndex modelIndex = ModelIndexSM_L200;
//      ModelIndex modelIndex = ModelIndexSP700;
//
//      NSString           *portSettings = [ModelCapability portSettingsAtModelIndex:modelIndex];
//      StarIoExtEmulation  emulation    = [ModelCapability emulationAtModelIndex   :modelIndex];
//
//      [AppDelegate setPortName    :portName];
//      [AppDelegate setModelName   :modelName];
//      [AppDelegate setMacAddress  :macAddress];
//      [AppDelegate setPortSettings:portSettings];
//      [AppDelegate setEmulation   :emulation];
//
//      [self.navigationController popViewControllerAnimated:YES];
    }
    else if (false) {     // Ex3. Indirect Setting.
//      ModelIndex modelIndex = [ModelCapability modelIndexAtModelName:modelName];
//
//      NSString           *portSettings = [ModelCapability portSettingsAtModelIndex:modelIndex];
//      StarIoExtEmulation  emulation    = [ModelCapability emulationAtModelIndex   :modelIndex];
//
//      [AppDelegate setPortName    :portName];
//      [AppDelegate setModelName   :modelName];
//      [AppDelegate setMacAddress  :macAddress];
//      [AppDelegate setPortSettings:portSettings];
//      [AppDelegate setEmulation   :emulation];
//
//      [self.navigationController popViewControllerAnimated:YES];
    }
    else {     // Ex4. Indirect Setting.
        ModelIndex modelIndex = [ModelCapability modelIndexAtModelName:modelName];
        
        if (modelIndex != ModelIndexNone) {
            NSString *message = [NSString stringWithFormat:@"Is your printer %@?", [ModelCapability titleAtModelIndex:modelIndex]];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirm." message:message delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            
            alertView.tag = AlertViewIndexConfirm0;
            
            [alertView show];
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirm." message:@"What is your printer?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            
            for (int i = 0; i < [ModelCapability modelIndexCount]; i++) {
                [alertView addButtonWithTitle:[ModelCapability titleAtModelIndex:[ModelCapability modelIndexAtIndex:i]]];
            }
            
            alertView.tag = AlertViewIndexConfirm1;
            
            [alertView show];
        }
    }
}

- (void)refreshPortInfo {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Select Interface." message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"LAN", @"Bluetooth", @"Bluetooth Low Energy", @"All", nil];
    
    alertView.tag = AlertViewIndexRefreshPort;
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == AlertViewIndexConfirm0) {
        if (buttonIndex == 1) {     // YES!!!
            NSArray *cellParam = _cellArray[_selectedIndexPath.row];
            
            NSString *portName   = cellParam[CellParamIndexPortName];
            NSString *modelName  = cellParam[CellParamIndexModelName];
            NSString *macAddress = cellParam[CellParamIndexMacAddress];
            
            ModelIndex modelIndex = [ModelCapability modelIndexAtModelName:modelName];
            
            NSString           *portSettings = [ModelCapability portSettingsAtModelIndex:modelIndex];
            StarIoExtEmulation  emulation    = [ModelCapability emulationAtModelIndex   :modelIndex];
            
            [AppDelegate setPortName    :portName];
            [AppDelegate setModelName   :modelName];
            [AppDelegate setMacAddress  :macAddress];
            [AppDelegate setPortSettings:portSettings];
            [AppDelegate setEmulation   :emulation];
            
            alertView.delegate = nil;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {     // NO!!!
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirm." message:@"What is your printer?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            
            for (int i = 0; i < [ModelCapability modelIndexCount]; i++) {
                [alertView addButtonWithTitle:[ModelCapability titleAtModelIndex:[ModelCapability modelIndexAtIndex:i]]];
            }
            
            alertView.tag = AlertViewIndexConfirm1;
            
            [alertView show];
        }
    }
    else if (alertView.tag == AlertViewIndexConfirm1) {
        if (buttonIndex != 0) {     // Not Cancel!!!
            NSArray *cellParam = _cellArray[_selectedIndexPath.row];
            
            NSString *portName   = cellParam[CellParamIndexPortName];
            NSString *modelName  = cellParam[CellParamIndexModelName];
            NSString *macAddress = cellParam[CellParamIndexMacAddress];
            
            ModelIndex modelIndex = [ModelCapability modelIndexAtIndex:buttonIndex - 1];
            
            NSString           *portSettings = [ModelCapability portSettingsAtModelIndex:modelIndex];
            StarIoExtEmulation  emulation    = [ModelCapability emulationAtModelIndex   :modelIndex];
            
            [AppDelegate setPortName    :portName];
            [AppDelegate setModelName   :modelName];
            [AppDelegate setMacAddress  :macAddress];
            [AppDelegate setPortSettings:portSettings];
            [AppDelegate setEmulation   :emulation];
            
            alertView.delegate = nil;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == AlertViewIndexRefreshPort) {
        if (buttonIndex == 0) {     // Cancel
            alertView.delegate = nil;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            self.blind = YES;
            
            [_cellArray removeAllObjects];
            
            _selectedIndexPath = nil;
            
            NSArray *portInfoArray;
            
            switch (buttonIndex) {
                default :
//              case 1  :     // LAN
                    portInfoArray = [SMPort searchPrinter:@"TCP:"];
                    break;
                case 2  :     // Bluetooth
                    portInfoArray = [SMPort searchPrinter:@"BT:"];
                    break;
                case 3  :     // Bluetooth Low Energy
                    portInfoArray = [SMPort searchPrinter:@"BLE:"];
                    break;
                case 4  :     // All
                    portInfoArray = [SMPort searchPrinter];
                    break;
            }
            
            NSString *portName   = [AppDelegate getPortName];
            NSString *modelName  = [AppDelegate getModelName];
            NSString *macAddress = [AppDelegate getMacAddress];
            
            int row = 0;
            
            for (PortInfo *portInfo in portInfoArray) {
                [_cellArray addObject:@[portInfo.portName, portInfo.modelName, portInfo.macAddress]];
                
                if ([portInfo.portName   isEqualToString:portName]   == YES &&
                    [portInfo.modelName  isEqualToString:modelName]  == YES &&
                    [portInfo.macAddress isEqualToString:macAddress] == YES) {
                    _selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
                }
                
                row++;
            }
            
            [_tableView reloadData];
            
            self.blind = NO;
        }
    }
}

@end
