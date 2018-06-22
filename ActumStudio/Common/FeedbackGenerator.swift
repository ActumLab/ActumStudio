//
//  FeedbackGenerator.swift
//  Mikomax
//
//  Created by Rafał Sowa on 21/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import AudioToolbox.AudioServices

/// This class manages haptic signals from taptic engine. Support: 6s,7,8
class FeedbackGenerator {
    
    /// 'Peek' feedback (weak boom)
    func peek() {
        let peek = SystemSoundID(1519)
        AudioServicesPlaySystemSound(peek)
    }
    
    /// 'Pop' feedback (strong boom)
    func pop() {
        let pop = SystemSoundID(1520)
        AudioServicesPlaySystemSound(pop)
    }
    
    /// 'Cancelled' feedback (three sequential weak booms)
    func cancelled() {
        let cancelled = SystemSoundID(1521)
        AudioServicesPlaySystemSound(cancelled)
    }
    
    /// 'Try Again' feedback (week boom then strong boom)
    func tryAgain() {
        let tryAgain = SystemSoundID(1102)
        AudioServicesPlaySystemSound(tryAgain)
    }
    
    /// 'Failed' feedback (three sequential strong booms)
    func failed() {
        let failed = SystemSoundID(1107)
        AudioServicesPlaySystemSound(failed)
    }
}
