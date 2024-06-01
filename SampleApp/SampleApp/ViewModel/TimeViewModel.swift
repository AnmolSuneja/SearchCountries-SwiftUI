//
//  TimeViewModel.swift
//  SampleApp
//
//  Created by Anmol Suneja on 01/06/24.
//

import Foundation
import Combine

class TimeViewModel: ObservableObject {
    @Published var currentTime: String = ""
    
    private var timer: AnyCancellable?
    
    init() {
        updateTime()
        scheduleNextMinute()
    }
    
    func scheduleNextMinute() {
        let now = Date()
        let nextMinute = Calendar.current.nextDate(after: now, matching: DateComponents(second: 0), matchingPolicy: .nextTime)!
        let interval = nextMinute.timeIntervalSince(now)
        
        timer = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTime()
                self?.scheduleNextMinute()
            }
    }
    
    func updateTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        currentTime = formatter.string(from: Date())
    }
    
    deinit {
        timer?.cancel()
    }
}
