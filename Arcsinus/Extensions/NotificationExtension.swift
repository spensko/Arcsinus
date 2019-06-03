//
//  NotificationExtension.swift
//  Arcsinus
//
//  Created by spens on 03/06/2019.
//  Copyright © 2019 arcsinus.com. All rights reserved.
//

import Foundation
import UIKit

extension Notification {
    var keyboardParameters: (frame: CGRect, size: CGFloat, duration: Double)? {
        if let userInfo = self.userInfo {
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
            if let frame = frame, let duration = duration {
                return (frame, min(frame.width, frame.height), duration)
            }
        }
        return nil
    }
}
