//
//  ConfrimViewController.swift
//  FinalProject_2014111535_ANY
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ConfrimViewController: UIViewController {

    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textMemo: UITextView!
    @IBOutlet var textLatitude: UILabel!
    @IBOutlet var textLongitude: UILabel!
    var detailAddress: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let address = detailAddress {
            textTitle.text = address.value(forKey: "detailName") as? String
            textMemo.text = address.value(forKey: "memo") as! String
            textLatitude.text = address.value(forKey: "latitude") as? String
            textLongitude.text = address.value(forKey: "longitude") as? String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toConfirmMap"{
            if let destination = segue.destination as? ConfirmMapViewController {
                //현재 위치 값을 Map에 보내기
           
                destination.Mlatitude = Double(self.textLatitude.text!)!
                destination.Mlongitude = Double(self.textLongitude.text!)!
                
            }
            
        }

    }
    

}
