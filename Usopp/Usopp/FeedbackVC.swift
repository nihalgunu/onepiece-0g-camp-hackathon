//
//  FeedbackVC.swift
//  Usopp
//
//  Created by David Slakter on 6/15/24.
//

import Foundation
import UIKit

class FeedbackVC: UIViewController {
    
    @IBOutlet weak var response1: UITextView!
    @IBOutlet weak var response2: UITextView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setResponses(_ res1: String, _ res2: String) {
        response1.text = res1
        response2.text = res2
    }

    @IBAction func submitPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
