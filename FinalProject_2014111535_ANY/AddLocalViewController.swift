//
//  AddLocalViewController.swift
//  FinalProject_2014111535_ANY
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class AddLocalViewController: UIViewController, UITextFieldDelegate{
   //추가
    @NSManaged var Subject: String
    @NSManaged var LocaltoDetail: NSSet
    
   @IBOutlet var textAddedLocal: UITextField!

    var localVC: UITableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Locals", in: context)
        
        //local recored를 새로 생성
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(textAddedLocal.text, forKey: "localName")
        object.setValue(Date(), forKey: "sortDate")
        
        do{
            try context.save()
            print("saved!")
            
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            
        }
        
        //현재의 View 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    /*
    @IBAction func addLocal(_ sender: UIButton) {
        if let targetVC = localVC as? LocalChoiceTableViewController {
            targetVC.addedLocal = self.textAddedLocal.text
            //현재의 입력 View Code pop up 시킴 (상위 뷰로)
            _ = self.navigationController?.popViewController(animated: true) //값 전달하고 자신은 사라짐
        }
        
    }
 */
    
    //TextField 사용 시 키보드 처리 코드
    @objc(textFieldShouldReturn:) func textFieldShouldReturn(_ textField: UITextField)->Bool{
        textField.resignFirstResponder()
        return true
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
