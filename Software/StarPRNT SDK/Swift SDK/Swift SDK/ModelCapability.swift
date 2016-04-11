//
//  ModelCapability.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import Foundation

enum ModelIndex: Int {     // Don't insert(Only addition)
    case None = 0
    case MPOP
    case FVP10
    case TSP100
    case TSP650II
    case TSP700II
    case TSP800II
    case SM_S210I
    case SM_S220I
    case SM_S230I
    case SM_T300I
    case SM_T400I
    case BSC10
    case SM_S210I_StarPRNT
    case SM_S220I_StarPRNT
    case SM_S230I_StarPRNT
    case SM_T300I_StarPRNT
    case SM_T400I_StarPRNT
    case SM_L200
    case SP700
}

class ModelCapability : NSObject {
    enum ModelCapabilityIndex: Int {
        case Title = 0
        case Emulation
        case PortSettings
        case ModelNameArray
    }
    
    static let modelIndexArray: [ModelIndex] = [
        ModelIndex.MPOP,
        ModelIndex.FVP10,
        ModelIndex.TSP100,
        ModelIndex.TSP650II,
        ModelIndex.TSP700II,
        ModelIndex.TSP800II,
        ModelIndex.SP700,                 // <-
        ModelIndex.SM_S210I,
        ModelIndex.SM_S220I,
        ModelIndex.SM_S230I,
        ModelIndex.SM_T300I,
        ModelIndex.SM_T400I,
        ModelIndex.SM_L200,               // <-
        ModelIndex.BSC10,
        ModelIndex.SM_S210I_StarPRNT,
        ModelIndex.SM_S220I_StarPRNT,
        ModelIndex.SM_S230I_StarPRNT,
        ModelIndex.SM_T300I_StarPRNT,
        ModelIndex.SM_T400I_StarPRNT
//      ModelIndex.SM_L200,
//      ModelIndex.SP700
    ]
    
    static var modelCapabilityDictionary: [ModelIndex: [AnyObject]] = [
        ModelIndex.MPOP              : ["mPOP",              StarIoExtEmulation.StarPRNT     .rawValue, "",         ["POP10"]],
        ModelIndex.FVP10             : ["FVP10",             StarIoExtEmulation.StarLine     .rawValue, "",         ["FVP10 (STR_T-001)"]],      // Only LAN model
        ModelIndex.TSP100            : ["TSP100",            StarIoExtEmulation.StarGraphic  .rawValue, "",         ["TSP113",
                                                                                                                     "TSP143"]],
        ModelIndex.TSP650II          : ["TSP650II",          StarIoExtEmulation.StarLine     .rawValue, "",         ["TSP654II (STR_T-001)",     // Only LAN model->
                                                                                                                     "TSP654 (STR_T-001)",
                                                                                                                     "TSP651 (STR_T-001)"]],
        ModelIndex.TSP700II          : ["TSP700II",          StarIoExtEmulation.StarLine     .rawValue, "",         ["TSP743II (STR_T-001)",
                                                                                                                     "TSP743 (STR_T-001)"]],
        ModelIndex.TSP800II          : ["TSP800II",          StarIoExtEmulation.StarLine     .rawValue, "",         ["TSP847II (STR_T-001)",
                                                                                                                     "TSP847 (STR_T-001)"]],     // <-Only LAN model
        ModelIndex.SM_S210I          : ["SM-S210i",          StarIoExtEmulation.EscPosMobile .rawValue, "mini",     ["SM-S210i"]],               // Sample->
        ModelIndex.SM_S220I          : ["SM-S220i",          StarIoExtEmulation.EscPosMobile .rawValue, "mini",     ["SM-S220i"]],
        ModelIndex.SM_S230I          : ["SM-S230i",          StarIoExtEmulation.EscPosMobile .rawValue, "mini",     ["SM-S230i"]],
        ModelIndex.SM_T300I          : ["SM-T300i",          StarIoExtEmulation.EscPosMobile .rawValue, "mini",     ["SM-T300i"]],
        ModelIndex.SM_T400I          : ["SM-T400i",          StarIoExtEmulation.EscPosMobile .rawValue, "mini",     ["SM-T400i"]],               // <-Sample
        ModelIndex.BSC10             : ["BSC10",             StarIoExtEmulation.EscPos       .rawValue, "escpos",   ["BSC10"]],
        ModelIndex.SM_S210I_StarPRNT : ["SM-S210i StarPRNT", StarIoExtEmulation.StarPRNT     .rawValue, "Portable", ["SM-S210i StarPRNT"]],      // Sample->
        ModelIndex.SM_S220I_StarPRNT : ["SM-S220i StarPRNT", StarIoExtEmulation.StarPRNT     .rawValue, "Portable", ["SM-S220i StarPRNT"]],
        ModelIndex.SM_S230I_StarPRNT : ["SM-S230i StarPRNT", StarIoExtEmulation.StarPRNT     .rawValue, "Portable", ["SM-S230i StarPRNT"]],
        ModelIndex.SM_T300I_StarPRNT : ["SM-T300i StarPRNT", StarIoExtEmulation.StarPRNT     .rawValue, "Portable", ["SM-T300i StarPRNT"]],
        ModelIndex.SM_T400I_StarPRNT : ["SM-T400i StarPRNT", StarIoExtEmulation.StarPRNT     .rawValue, "Portable", ["SM-T400i StarPRNT"]],      // <-Sample
        ModelIndex.SM_L200           : ["SM-L200",           StarIoExtEmulation.StarPRNT     .rawValue, "Portable", ["SM-L200"]],
        ModelIndex.SP700             : ["SP700",             StarIoExtEmulation.StarDotImpact.rawValue, "",         ["SP712 (STR-001)",          //Only LAN model
                                                                                                                     "SP717 (STR-001)",
                                                                                                                     "SP742 (STR-001)",
                                                                                                                     "SP747 (STR-001)"]]
    ]
    
    static func modelIndexCount() -> Int {
        return ModelCapability.modelIndexArray.count
    }
    
    static func modelIndexAtIndex(index: Int) -> ModelIndex {
        return ModelCapability.modelIndexArray[index]
    }
    
    static func titleAtModelIndex(modelIndex: ModelIndex) -> String! {
        return ModelCapability.modelCapabilityDictionary[modelIndex]![ModelCapabilityIndex.Title.rawValue] as! String
    }
    
    static func emulationAtModelIndex(modelIndex: ModelIndex) -> StarIoExtEmulation {
        return StarIoExtEmulation(rawValue: ModelCapability.modelCapabilityDictionary[modelIndex]![ModelCapabilityIndex.Emulation.rawValue] as! Int)!
    }
    
    static func portSettingsAtModelIndex(modelIndex: ModelIndex) -> String! {
        return ModelCapability.modelCapabilityDictionary[modelIndex]![ModelCapabilityIndex.PortSettings.rawValue] as! String
    }
    
    static func modelIndexAtModelName(modelName: String!) -> ModelIndex {
        for (modelIndex, anyObject) in ModelCapability.modelCapabilityDictionary {
            let modelNameArray: [String] = anyObject[ModelCapabilityIndex.ModelNameArray.rawValue] as! [String]
            
//          for var i: Int = 0; i < modelNameArray.count; i += 1 {
            for     i: Int in 0 ..< modelNameArray.count         {
                if modelName.hasPrefix(modelNameArray[i]) == true {
                    return modelIndex
                }
            }
        }
        
        return ModelIndex.None
    }
}
