//
//  SettingsData.swift
//  BSPWon
//
//  Created by skkuwon on 2022/04/15.
//

import Foundation

struct SettingsData
{
    
    struct TimerSetting
    {
        let setting_name : String = "Simple Timer"
        var time_in_seconds : Int = 0
    }
    
    struct SensoryNeuromorphicSetting
    {
        // time in seconds
        let setting_name : String = "Neuromorphic Semicon"
        static var averaging_time : Int = 3
        static var sign_time : Int = 4
    }
    
}
