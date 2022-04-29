//
//  AutomaticPulsing.swift
//  BSPWon
//
//  Created by skkuwon on 2022/04/28.
//

import Foundation
import UIKit

struct Pulse_State
{
    static var off_state : Bool = true
    static var addup_state : Bool = false
    static var averaging_state : Bool = false
    static var sign_state : Bool = false
    static var end_state : Bool = false
}

class AutomaticPulsing
{
    private var _time_count : Int
    private var timer : Timer?
    
    init()
    {
        _time_count = 0
    }
    
    /*
     off_state         : <AUTOMATICPULSEOFF>
     addup_state       : <AUTOMATICPULSEADDUP>
     averaging_state   : <AUTOMATICPULSEAVERAGE>
     sign_state        : <AUTOMATICPULSESIGN>
     end_state         : <AUTOMATICPULSEEND>
     */
    @objc
    func pulse_timer_callback()
    {
        // reads data from data structure edited by user in Settings View Controller
        _time_count += 1
        let avg_time = SettingsData.SensoryNeuromorphicSetting.averaging_time
        let sign_time = SettingsData.SensoryNeuromorphicSetting.sign_time
        
        // addup state
        if(_time_count < avg_time && Pulse_State.addup_state == false)
        {
            BLEStack.shared.writeValue(data: "<AUTOMATICPULSEADDUP>")
            Pulse_State.off_state = false
            Pulse_State.addup_state = true
            
            // signal UI to show "Stay still.."
            
        }
        // averaging state
        else if(_time_count == avg_time && Pulse_State.averaging_state == false)
        {
            BLEStack.shared.writeValue(data: "<AUTOMATICPULSEAVERAGE>")
            Pulse_State.addup_state = false
            Pulse_State.averaging_state = true
        }
        // sign state
        else if(_time_count > avg_time && _time_count < (avg_time + sign_time) && Pulse_State.sign_state == false)
        {
            BLEStack.shared.writeValue(data: "<AUTOMATICPULSESIGN>")
            Pulse_State.averaging_state = false
            Pulse_State.sign_state = true
            
            // signal UI to show "Perform gesture!"
            
        }
        // end state
        else if(_time_count == (avg_time + sign_time) && Pulse_State.end_state == false)
        {
            BLEStack.shared.writeValue(data: "<AUTOMATICPULSEEND>")
            Pulse_State.sign_state = false
            Pulse_State.end_state = true
            
            // signal UI to show "Test done. Ready."
            
        }
        else if(_time_count > (avg_time + sign_time) && Pulse_State.off_state == false)
        {
            BLEStack.shared.writeValue(data: "<AUTOMATICPULSEOFF>")
            Pulse_State.off_state = true
            _time_count = 0
            timer?.invalidate()
        }
        
    }
    
    func start_pulsing()
    {
        if timer != nil && timer!.isValid
        {
            timer!.invalidate()
        }
        // this timer is called every 0.1 second
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: #selector(pulse_timer_callback),
                                     userInfo: nil, repeats: true)
    }
}
