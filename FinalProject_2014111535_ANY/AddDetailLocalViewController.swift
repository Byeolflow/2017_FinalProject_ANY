//
//  AddDetailLocalViewController.swift
//  FinalProject_2014111535_ANY
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class AddDetailLocalViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var textDetailAddress: UITextField!
    @IBOutlet var toggle: UISwitch!
    @IBOutlet var latitude: UILabel!
    @IBOutlet var longitude: UILabel!
    @IBOutlet var textMemo: UITextView!
    @IBOutlet var confrimBtn: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()
//    var toMapVC: UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggle.isOn = false
        latitude.text = "스위치를 눌러주세요"
        longitude.text = "스위치를 눌러주세요"
        
        // Do any additional setup after loading the view.
    }
    
    //CoreData사용할 때
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "LocalDetails", in: context)
        
        
        
        //추가 끝
        //local recored를 새로 생성
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(textDetailAddress.text, forKey: "detailName")
        object.setValue(textMemo.text, forKey: "memo")
        object.setValue(Date(), forKey: "saveDate")
      //  object.setValue(latitude.text, forKey: "latitude")
      //  object.setValue(longitude.text, forKey: "longitude")

        
        //기본값 설정.
        if latitude.text == "스위치를 눌러주세요" {
            latitude.text = "37.628375"
            longitude.text = "127.090718"
        }
        
        object.setValue(latitude.text, forKey: "latitude")
        object.setValue(longitude.text, forKey: "longitude")
        
 
        
        
                
        
        do{
            try context.save()
            print("saved!")
            
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            
        }
        
        //현재의 View 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    //TextField 사용 시 키보드 처리 코드
    @objc(textFieldShouldReturn:) func textFieldShouldReturn(_ textField: UITextField)->Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
    //TextView 사용시 키보드 처리 코드
    @IBAction func confirmContext(_ sender: UIButton) {
        textMemo.resignFirstResponder()
    }
    
    
    //위치 정보 받아오기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if toggle.isOn == true {
        //가장 최근의 위치 값
        let location: CLLocation = locations[locations.count-1]
        
        latitude.text = String(format: "%.6f", location.coordinate.latitude)
        longitude.text = String(format: "%.6f", location.coordinate.longitude)
        }
        else {
            latitude.text = "스위치를 눌러주세요"
            longitude.text = "스위치를 눌러주세요"
        }
        
    }
    
    @IBAction func toggleSwitch(_ sender: UISwitch) {
        if toggle.isOn == true {
            self.locationManager.startUpdatingLocation()
            
        }
        else if toggle.isOn == false{
            self.locationManager.stopUpdatingHeading()

            
            
        }
        
    }
    
    //위치 허가
    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled(){
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                let alert = UIAlertController(title: "오류 발생", message: "위치서비스 기능이 꺼져있음", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
                self.toggle.isOn = false
            }
            else {
                
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                
            }
            
        }
        else{
            let alert = UIAlertController(title:"오류 발생", message: "위치서비스 제공 불가", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
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
        if segue.identifier == "toAddedMap"{
            if let destination = segue.destination as? MapForAddedViewController {
                //현재 위치 값을 Map에 보내기
                    if toggle.isOn == true {
                        destination.Mlatitude = Double(self.latitude.text!)!
                        destination.Mlongitude = Double(self.longitude.text!)!
        
                    }
                    else {
                        //서울여자대학교 위치, 기본
                        destination.Mlatitude = 37.628375
                        destination.Mlongitude = 127.090718
                    }
            }
            
        }
        
        
    }
    
    
}
    


