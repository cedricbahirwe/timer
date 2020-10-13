//
//  ContentView.swift
//  TimerApp
//
//  Created by Cedric Bahirwe on 8/17/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import SwiftUI


enum TimerMode {
    case running, paused, initial
}

struct ContentView: View {
    @State var selectedPickerIndex = 0
    
    @State var isSharedSheet = false
    
    @ObservedObject var timerManager = TimerManager()
    
    var availableMinutes = Array(1...59)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(self.secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))")
                    .font(.system(size: 80))
                    .padding(.top, 80)
                
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .foregroundColor(.orange)
                    .onTapGesture {
                        if self.timerManager.timerMode == .initial {
                                self.timerManager.setTimerLength(minutes: self.availableMinutes[self.selectedPickerIndex] * 60)
                        }
                      self.timerManager.timerMode == .running ? self.timerManager.pause() :  self.timerManager.start()
                }
                
                
                if timerManager.timerMode == .paused {
                    Image(systemName: "gobackward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                self.timerManager.reset()
                            }
                    }
                }
                if timerManager.timerMode == .initial {
                    Picker(selection: $selectedPickerIndex, label: Text("")) {
                        ForEach(0 ..< availableMinutes.count/10) {
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .labelsHidden()
                    
                }
                Spacer()
                
            }
            .navigationBarTitle("Timer")
        .navigationBarItems(trailing:
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
                .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.accentColor
                )
                    .onTapGesture {
                        self.shareButton()
                }
            }
            )
        }
    }
    
     func secondsToMinutesAndSeconds (seconds : Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        return "\(minuteStamp):\(secondStamp)"
    }
    func shareButton() {
        guard let url = URL(string: "https://rwandabuildprogram.com/") else { return }
        
        let acttivtyVC = UIActivityViewController(activityItems: [url], applicationActivities: [])
        
        UIApplication.shared.windows.first?.rootViewController?.present(acttivtyVC, animated: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
