//
//  FeedbackVC.swift
//  Usopp
//
//  Created by David Slakter on 6/15/24.
//

import Foundation
import UIKit

class FeedbackVC: UIViewController {
    
    @IBOutlet weak var toggler: UISegmentedControl!
    @IBOutlet weak var response1: UITextView!
    @IBOutlet weak var response2: UITextView!
    
    var res1: String?
    var res2: String?
    
    var onDismiss: ((String) -> Void)? = nil

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        response1.text = res1
        response2.text = res2
    }

    @IBAction func submitPressed(_ sender: Any) {
        onDismiss?(toggler.selectedSegmentIndex == 0 ? res1!: res2!)
        self.dismiss(animated: true, completion: nil)
    }
}
