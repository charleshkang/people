//
//  Alert.swift
//  People
//
//  Created by Charles Kang on 3/25/17.
//  Copyright © 2017 Charles Kang. All rights reserved.
//

import UIKit

struct Alert {
    
    static func error(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
}
