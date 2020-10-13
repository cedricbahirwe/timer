//
//  TimerManager.swift
//  TimerApp
//
//  Created by Cedric Bahirwe on 8/17/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class TimerManager: ObservableObject {
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
//        {
//        didSet {
//            objectWillChange.send(self)
//        }
//    }
    var timer = Timer()
//    let objectWillChange = PassthroughSubject<TimerManager, Never >()
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in

            if self.secondsLeft == 0 {
                self.reset()
            }
            self.secondsLeft -= 1
            
        })
        
    }
    
    func reset() {
        timerMode = .initial
        secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause() {
        timerMode = .paused
        timer.invalidate()
    }
    
    func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
        
        
    }
}
