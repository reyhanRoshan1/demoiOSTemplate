//
//  UtilityMangr.swift
//  CampersCloset
//
//  Created by Surinder Kumar on 11/05/22.
//
import Foundation
import UIKit
import NVActivityIndicatorView
import Alamofire
import Kingfisher


typealias completionHandler = (Bool,String)->()
typealias completionHandlerPage = (Bool,String,Int)->()
typealias pageCompletionHandler = (Bool,Bool,String)->()


class UtilityMangr : NSObject{
    
    public static var shared = UtilityMangr()
    
    private override init() {}
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
     var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var pushDeviceToken : String{
        get{
            UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: "fcmToken")
        }
    }
       
    var navHeaderCenterValue : CGFloat{
        get{
            return 17
        }
    }
    
    var appToken : String{
        get{
            UserDefaults.standard.string(forKey: "appToken") ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: "appToken")
        }
    }
    
    var startTime : String{
        get{
            UserDefaults.standard.string(forKey: "startTime") ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: "startTime")
        }
    }
    
    var endTime : String{
        get{
            UserDefaults.standard.string(forKey: "endTime") ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: "endTime")
        }
    }
    
    var backgroundTime : String{
        get{
            UserDefaults.standard.string(forKey: "backgroundTime") ?? ""
        }set{
            UserDefaults.standard.setValue(newValue, forKey: "backgroundTime")
        }
    }
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func push(identifier:String,story:Storyboard,controller:UIViewController){
        let stry = UIStoryboard(name: story.rawValue, bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier: identifier)
        controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func showAlert(title:String,msg:String,vwController:UIViewController){
        
        let alertCon = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertCon.addAction(alertAction)
        
        vwController.present(alertCon, animated: true, completion: nil)
        
    }
    
    func showAlertWithCompletion(title:String,msg:String,vwController:UIViewController,completion:@escaping()->()){
        let alertCon = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        
        alertCon.addAction(alertAction)
        
        vwController.present(alertCon, animated: true, completion: nil)
        
    }
    
    func showAlertWithCompletionWithButton(title:String,msg:String,action:[String],vwController:UIViewController,completion:@escaping(String)->()){
        let alertCon = UIAlertController(title: title, message: msg, preferredStyle: .alert)
       
        for actString in action{
            let alertAction = UIAlertAction(title: actString, style: .default) { (_) in
                completion(actString)
            }
            alertCon.addAction(alertAction)
        }
        
        vwController.present(alertCon, animated: true, completion: nil)
        
    }
    
    /*
    func getUserDetail()->UserInfoModel{
        let defaults = UserDefaults.standard
        var storeDetail = UserInfoModel()
        if let savedPerson = defaults.object(forKey: "userDetail") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(UserInfoModel.self, from: savedPerson) {
                //print(loadedPerson.data.name)
                storeDetail = loadedPerson
            }
        }
        return storeDetail
    }
    */
    func getHeaderToken()->HTTPHeaders{
        let header : HTTPHeaders = ["Accept":"application/json","Authorization":"Bearer \(appToken)"]
            //print(header.description)
        Logger.log(header.description)
        return header
    }

    
    func removeUserDefault(_ keys:[String]){
        for key in keys{
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    func removeDetailsLogout(){
        removeUserDefault(["userDetail","appToken"])
    }
    
    func setImage(url:String,imgVw:UIImageView){
        imgVw.kf.indicatorType = .activity
        //DispatchQueue.main.async {
        imgVw.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "defaultImage"), options: nil) { (result) in
            switch result{
            case .success(let _):
                break
            case .failure(let error):
                print("dsds")
                // print(error.localizedDescription)
            }
            // }
        }
    }
    
    func decorateText(sub:String, des:String,subFont:String,desFont:String,subSize:CGFloat,desSize:CGFloat,subColor:UIColor,desColor:UIColor)->NSAttributedString{
        let textAttributesOne = [NSAttributedString.Key.foregroundColor: subColor, NSAttributedString.Key.font: UIFont(name: subFont, size: subSize)]
        let textAttributesTwo = [NSAttributedString.Key.foregroundColor: desColor, NSAttributedString.Key.font: UIFont(name: desFont, size: desSize)]
        
        let textPartOne = NSMutableAttributedString(string: sub, attributes: textAttributesOne as [NSAttributedString.Key : Any])
        let textPartTwo = NSMutableAttributedString(string: des, attributes: textAttributesTwo as [NSAttributedString.Key : Any])
        
        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        return textCombination
    }
    
    func isValidEmail(testStr:String) -> Bool {
            // print("validate calendar: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
    
    func dateFormatter(inputDate:String,inputFormat:String,outputFormat:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat //"yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from:inputDate) else{return ""}
        dateFormatter.dateFormat = outputFormat//"yyyy-MM-dd h:mm a"
        let datestr = dateFormatter.string(from: date)
        return datestr
    }
    
}

class Indicator : UIViewController,NVActivityIndicatorViewable{
   static var shared = Indicator()
    let size = CGSize(width:40, height: 40)
    
    func start(_ msg : String,loaderColor:UIColor){
        startAnimating(size, message: msg, messageFont: UIFont.systemFont(ofSize: 18), type: NVActivityIndicatorType.circleStrokeSpin, color: loaderColor, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.clear, textColor: .white)
    }
    
    func stop(){
        stopAnimating()
    }
    
   
    
}

class Logger {

    class func log(_ msg:Any){
        #if DEBUG
           // print("\(msg)")
        #endif
    }
}
/*
 let loadVwBg = UIView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 42.5, y:  (UIScreen.main.bounds.height / 2) - 42.5, width: 85, height: 85))
 loadVwBg.backgroundColor = UIColor.black.withAlphaComponent(0.50)
 loadVwBg.layer.cornerRadius = 12
 loadVwBg.addSubview(activityIndicatorView)
 */
