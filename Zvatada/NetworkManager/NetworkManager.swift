//
//  NetworkManager.swift
//  Zvatada
//
//  Created by Sushil Mahto on 10/11/22.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage
import SVProgressHUD
import SkeletonView
import ViewAnimator
import SwiftUI

import SwiftUI
class NetworkManager: NSObject {
    //Login Request Method
     
    
    class func postRequestLogin(remainingUrl:String, parameters: [String:Any] , completion: @escaping ((_ data: JSON) -> Void)) {
        print("parameters posted : ",parameters)
        let completeUrl = self.getBaseUrl() + remainingUrl
        
        print ("complete url : ", completeUrl)
    //    SHOW_ACTIVITY()

       
        let loginToken = NetworkManager.getGeneralToken()
        let headers : HTTPHeaders = ["Authorization":"Bearer \(loginToken)","Accept":"application/json",
                                     "description" : "",
                                     "type" : "default",
                                     "enabled" : "true"
        ]
        
        
        Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseData { response in
            //debugPrint(response)

           // response.response?.allHeaderFields
            print("headers :\(response.response?.allHeaderFields["Authorization"])")
            
            if(response.data != nil){
               
             //  SVProgressHUD.dismiss()
               // HIDE_ACTIVITY()
                let swiftyJsonVar = try! JSON(data: response.data!)
                if !swiftyJsonVar["IS_ERROR"].boolValue{
                    let authHeader = response.response?.allHeaderFields["Authorization"] as! String
                    UserDefaults.standard.set(authHeader, forKey: "userToken")
                    print("user token :\(authHeader)")
                }
               // print("ResponseData : ",swiftyJsonVar)
                completion(swiftyJsonVar)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }
            else
            {
//                 HIDE_ACTIVITY()
                print("No response")
              //  SVProgressHUD.showError(withStatus: "Unable to process request. Please try again.")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    //Post Request Method
   
    class func postRequestUsingLoginToken(remainingUrl:String, parameters: [String:Any] , completion: @escaping ((_ data: JSON) -> Void)) {
        print("parameters posted : ",parameters)
        let completeUrl = self.getBaseUrl() + remainingUrl

        print ("complete url : ", completeUrl)
    //    SHOW_ACTIVITY()

        let loginToken = NetworkManager.getGeneralToken()
        let headers : HTTPHeaders = ["Authorization":"",
                                     "description" : "",
                                     "type" : "default",
                                     "enabled" : "true",
                                     "Content-Type":"application/x-www-form-urlencoded",
                                     "Connection":"keep-alive"
        ]
        
        
        Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseData { response in
           // debugPrint(response)
           // response.response?.allHeaderFields
           // print("headers :\(response.response?.allHeaderFields["Authorization"])")
            
            if(response.data != nil){
                //let authHeader = response.response?.allHeaderFields["Authorization"] as! String
                
                //UserDefaults.standard.set(authHeader, forKey: "userToken")
             //  SVProgressHUD.dismiss()
               // HIDE_ACTIVITY()
                let swiftyJsonVar = try! JSON(data: response.data!)
                
               // print("ResponseData : ",swiftyJsonVar)
                completion(swiftyJsonVar)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }
            else
            {
//                 HIDE_ACTIVITY()
                print("No response")
              //  SVProgressHUD.showError(withStatus: "Unable to process request. Please try again.")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    
    }
    
    
    
    class func postRequestWithUtiityTokenReturnJson(remainingUrl:String, parameters: [String:Any] , completion: @escaping ((_ data: JSON) -> Void)) {
        //print("parameters posted : ",parameters)
        let completeUrl = self.getBaseUrl() + remainingUrl
        print ("complete url : ", completeUrl)
        let UtilityToken = NetworkManager.getUtilityToken()
        print ("UtilityToken : ", UtilityToken)
        //print("Parameters : ", parameters)
        let headers : HTTPHeaders = ["Authorization":"",
                                     "description" : "",
                                     "type" : "default",
                                     "enabled" : "true",
                                     "Content-Type":"application/x-www-form-urlencoded",
                                     "Connection":"keep-alive",
                                     "Accept":"application/json"
        ]
        
     Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseData { response in

            if(response.data != nil){
                let swiftyJsonVar = try! JSON(data: response.data!)
                print("Response in Utility token \(swiftyJsonVar)")
                completion(swiftyJsonVar)
                
            }
            else
            {
                print("No response")
            }
        }
    }
    
    class func postRequestWithUserData(remainingUrl:String, parameters: [String:Any] , completion: @escaping ((_ data: JSON) -> Void)) {
        print("parameters posted : ",parameters)
        let completeUrl = self.fixBaseUrl() + remainingUrl

        print ("complete url : ", completeUrl)

        let userToken = NetworkManager.getUserToken()
        let headers : HTTPHeaders = ["Authorization":"Bearer \(userToken)","Accept":"application/json",
                                     "description" : "",
                                     "type" : "default",
                                     "enabled" : "true"
        ]
        Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseData { response in
            var statusCode = response.response?.statusCode
            print("status  :\(response.response?.statusCode)")
            print("status code : \(statusCode)")
            if statusCode == 422{
//                let errorJson = ["statusCode" : "\(statusCode)"]
//
//                let jsonData = try? JSONSerialization.data(withJSONObject: errorJson, options: .prettyPrinted)
//
//                let swiftyJsonVar = try! JSON(data: jsonData!)
//                print("response: \(swiftyJsonVar)")
//                completion(swiftyJsonVar)
                let swiftyJsonVar = try! JSON(data: response.data!)
                let errorJson = ["statusCode": statusCode, "message": "\(swiftyJsonVar["message"].stringValue)"]
                              let jsonData = try? JSONSerialization.data(withJSONObject: errorJson, options: .prettyPrinted)
                              if let jsonData = jsonData {
                                  let swiftyJsonVar = try? JSON(data: jsonData)
                                  if let swiftyJsonVar = swiftyJsonVar {
                                      print("response: \(swiftyJsonVar)")
                                      completion(swiftyJsonVar)
                                  }
                              }
            }else{
                if(response.data != nil){
                    let swiftyJsonVar = try! JSON(data: response.data!)
                    completion(swiftyJsonVar)
                    print("detail Api is\(swiftyJsonVar)")
                 }else{
                    print("No response")
                }
            }

        }
    }
    class func postRequestWithUtiityTokenReturnData(remainingUrl:String, parameters: [String:Any] , completion: @escaping ((_ data: Data) -> Void)) {
        print("parameters posted : ",parameters)
        let completeUrl = self.getBaseUrl() + remainingUrl

        print ("complete url : ", completeUrl)
        let UtilityToken = NetworkManager.getUtilityToken()
        print ("UtilityToken : ", UtilityToken)

        
        let headers : HTTPHeaders = ["Authorization":"",
                                     "description" : "",
                                     "type" : "default",
                                     "enabled" : "true",
                                     "Content-Type":"application/x-www-form-urlencoded",
                                     "Connection":"keep-alive",
                                     "Accept":"application/json"
        ]
        
     Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseData { response in
            //debugPrint(response)
         var statusCode = response.response?.statusCode
         print("status code : \(statusCode)")
         
            if(response.data != nil){
                let swiftyJsonVar = try! JSON(data: response.data!)
                print("Response with Utility token \(swiftyJsonVar)")
                completion(response.data!)
            }
            else
            {
                print("No response")
            }
        }
    }
    
    
    class func postRequestWithUserTokenFixUrlRetunJson(remainingUrl:String, parameters: [String:Any] , completion: @escaping ((_ data: JSON) -> Void)) {
        print("parameters posted : ",parameters)
        let completeUrl = self.fixBaseUrl() + remainingUrl

        print ("complete url : ", completeUrl)

        let userToken = NetworkManager.getUserToken()
        let headers : HTTPHeaders = ["Authorization":"Bearer \(userToken)","Accept":"application/json",
                                     "description" : "",
                                     "type" : "default",
                                     "enabled" : "true",
                                     "Content-Type":"application/x-www-form-urlencoded",
                                     "Connection":"keep-alive"
        ]
        Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseData { response in
            if(response.data != nil){
                let swiftyJsonVar = try! JSON(data: response.data!)
                completion(swiftyJsonVar)
             }
            else
            {
                print("No response")
            }
        }
    }
    class func postRequestWithUserTokenFixUrlRetunData(remainingUrl:String,parameters: [String:Any],Token:String  , completion: @escaping ((_ data: Data) -> Void)) {
        print("parameters posted : ",parameters)
        let completeUrl = self.fixBaseUrl() + remainingUrl
//        print ("complete url : ", completeUrl)
//        let userToken = NetworkManager.getUserToken()
        let headers : HTTPHeaders = ["Authorization":"Bearer \(Token)",
                                     "Accept":"application/json",
                                     "description" : "",
                                     "type" : "default",
                                     "enabled" : "true"
        ]
        //let query: URLQueryItem = ""
        Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseData { response in
            var statusCode = response.response?.statusCode
            print("statusCode :\(statusCode)")



            if(response.data != nil){
                let swiftyJsonVar = try! JSON(data: response.data!)
                print("Response is: ", swiftyJsonVar)
                completion(response.data!)



             }
            else
            {
                print("No response")
            }




        }
    }

    class func postRequestWithUserTokenFixUrlRetunData(remainingUrl:String, parameters: [String:Any] , completion: @escaping ((_ data: Data) -> Void)) {
        print("parameters posted : ",parameters)
        let completeUrl = self.fixBaseUrl() + remainingUrl
        print ("complete url : ", completeUrl)
        let userToken = NetworkManager.getUserToken()
        let headers : HTTPHeaders = ["Authorization":"Bearer \(userToken)","Accept":"application/json",
                                     "description" : "",
                                     "type" : "default",
                                     "enabled" : "true"
        ]
        Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseData { response in
            if(response.data != nil){
                let swiftyJsonVar = try! JSON(data: response.data!)
                print("Response : ", swiftyJsonVar)
                completion(response.data!)
             }
            else
            {
                print("No response")
            }
        }
    }
    
    
    class func postRequestDynamicHeaderWithDynamicUrlReturnJson(remainingUrl:String, parameters: [String:Any] ,header : HTTPHeaders , completion: @escaping ((_ data: JSON) -> Void)) {
        print("parameters posted : ",parameters)
        let completeUrl = self.getBaseUrl() + remainingUrl
        print ("complete url : ", completeUrl)
     Alamofire.AF.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: header).responseData { response in
           if(response.data != nil){
               let swiftyJsonVar = try! JSON(data: response.data!)
               completion(swiftyJsonVar)
           }
            else
            {
                print("No response")
              }
        }
    }


    class func imageUpload(url: String,image: UIImage,params: [String : Any],token:String,imagekey:String,completion: @escaping ((_ data: JSON) -> Void)) {
        let completeUrl = NetworkManager.fixBaseUrl() + url
        var headers: HTTPHeaders {
            get {
                return [
                    "Authorization" : "Bearer \(token)",
                    "description" : "",
                    "type" : "default",
                    "enabled" : "true",
                    
                ]
            }
        }
      
        AF.upload(multipartFormData: { multiPart in
            for p in params {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            multiPart.append(image.jpegData(compressionQuality: 0.4)!, withName: "\(imagekey)", fileName: "file.jpg", mimeType: "image/jpg")
        }, to: completeUrl, method: .post, headers: headers)
        .responseJSON{ response  in
            switch response.result {
            case .success(let resut):
                print("upload success result: \(resut)")
                if(response.data != nil){
                    let swiftyJsonVar = try! JSON(data: response.data!)
                    completion(swiftyJsonVar)
                   // var imageUrl = swiftyJsonVar["FILE_URL"].stringValue
                        //self.parent.PhotoUrl = imageUrl
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }
                else
                {
                    print("No response")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            case .failure(let err):
                print("upload err: \(err)")
            }
        }
    }
    
    class func multipleImgUpload(url: String,imageArray: [UIImage],params: [String : Any],token:String,imagekeyArray:[String],completion: @escaping ((_ data: JSON) -> Void)) {
        let completeUrl = NetworkManager.getBaseUrl() + url
        var headers: HTTPHeaders {
            get {
                return [
                    "Authorization" : "Bearer \(token)",
                    "description" : "",
                    "type" : "default",
                    "enabled" : "true",
                    
                ]
            }
        }
        print("parameter : \(params)")
        print("parameter : \(token)")
        // let httpHeaders = HTTPHeaders(headers)
        var i = 0
        AF.upload(multipartFormData: { multiPart in
            for p in params {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            for image in imageArray{
                multiPart.append(image.jpegData(compressionQuality: 0.4)!, withName: "\(imagekeyArray[i])", fileName: "file.jpg", mimeType: "image/jpg")
                i = i+1
            }
//            multiPart.append(image.jpegData(compressionQuality: 0.4)!, withName: "\(imagekey)", fileName: "file.jpg", mimeType: "image/jpg")
        }, to: completeUrl, method: .post, headers: headers)
        .responseJSON{ response  in
            switch response.result {
            case .success(let resut):
                print("upload success result: \(resut)")
                if(response.data != nil){
                    let swiftyJsonVar = try! JSON(data: response.data!)
                    completion(swiftyJsonVar)
                   // var imageUrl = swiftyJsonVar["FILE_URL"].stringValue
                        //self.parent.PhotoUrl = imageUrl
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }
                else
                {
                    print("No response")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            case .failure(let err):
                print("upload err: \(err)")
            }
        }
    }
    

  
    
   
    
    class func isConnectedToNetwork1() -> Bool {
        
        return NetworkReachabilityManager()!.isReachable
    }
    
    class func isConnectedToNetwork () -> Bool{
           return true
       }
   
    class func getBaseUrl() -> String {
    
        return self.updatedBaseURL()
    }
    
    class func fixBaseUrl() -> String {
      
        return "https://www.zvatada.com/api/"
    }
    
    
    class func updatedBaseURL() -> String{
        if let savedUserId = UserDefaults.standard.value(forKey: "baseUrl") {
            return savedUserId as! String
        }else{
            return "https://www.zvatada.com/api/"
       
        }
    }
    
    class func checkAccoundAdded() -> String{
        if let savedUserId = UserDefaults.standard.value(forKey: "checkAccoundAdded") {
            return savedUserId as! String
        }else{
            return "0"
        }
    }
    class func getUserId() -> String{
        if let savedUserId = UserDefaults.standard.value(forKey: "UserID") {
            return savedUserId as! String
        }else{
            return ""
        }
    }
   
    class func getUserName() -> String{
        if let savedUserId = UserDefaults.standard.value(forKey: "userName") {
            return savedUserId as! String
        }else{
            return ""
        }
    }
    
    class func getUserMobile() -> String{
           if let savedUserId = UserDefaults.standard.value(forKey: "userMobile") {
               return savedUserId as! String
           }else{
               return ""
           }
       }
    
   
    class func getUserEmail() -> String{
        if let savedCartId = UserDefaults.standard.value(forKey: "userEmail") {
            return savedCartId as! String
        }else{
            return ""
        }
    }
    
    
    class func getUserVerified() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "userVerified") {
               return savedCartId as! String
           }else{
               return "0"
           }
       }
    
   
    class func getUserImage() -> String{
        if let savedCartId = UserDefaults.standard.value(forKey: "userImage") {
            return savedCartId as! String
        }else{
            return ""
        }
    }
    
   
   
   
    class func getAddressID() -> String{
        if let savedCartId = UserDefaults.standard.value(forKey: "AddressID") {
            return savedCartId as! String
        }else{
            return ""
        }
    }
    
   
    class func getDeviceToken() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "deviceToken") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
 
    class func getUtilityToken() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "UtilityToken") {
               return savedCartId as! String
           }else{
             
              // return "WEZuckloV25kbjZxMkw5VjdyUDFZMkFVY1dDUWZlOGlubm9RdlVKOStXekFSV0FrZmczeEFJeWRtUzJkSW1EVw=="
               return ""
           }
       }
    
    class func getUserToken() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "userToken") {
               return savedCartId as! String
           }else{
               return "Zy8va1N0UVgyK3REWFNlYktMVlF2eEdiTmtDTUZZVWFiSWFRNjRpT3Fudz0="
               //return ""
           }
       }

    class func getGeneralToken() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "generalToken") {
               return savedCartId as! String
           }else{
               return "dWdvaW52ZW50aXZlQDEyMw=="
           }
       }

   
    class func getDefaultAddressId() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "DefaultAddressId") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
    
    class func getisDefaultAddressId() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "isdefaultAddress") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
    class func getDefaultName() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "DefaultName") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
    class func getDefaultNumber() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "DefaultNumber") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
    class func getDefaultAddress() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "DefaultAddress") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
    class func getUserType() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "userType") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
    
   
    class func getBasketID() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "BasketID") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
   
    class func getPrimaryUtilityLogo() -> String{
           if let savedCartId = UserDefaults.standard.value(forKey: "primaryUtilityLogo") {
               return savedCartId as! String
           }else{
               return ""
           }
       }
   
   
   
   
    class func getCurrentDate() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let DateInFormat = dateFormatter.string(from: todaysDate as Date)
        return DateInFormat
    }
    

    
    class func getCurrentTime() -> String {
         let currentTime = NSDate()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "HH:mm"
        let timeInFormat = dateFormatter.string(from: currentTime as Date)
         return timeInFormat
     }
    
   
   
   
    
    
    


    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    

}
class LocalStorage {
    
    private static let myKey: String = "myKey"
    
    public static var myValue: String {
        set {
            UserDefaults.standard.set(newValue, forKey: myKey)
        }
        get {
            return UserDefaults.standard.string(forKey: myKey) ?? ""
        }
    }
    
    public static func removeValue() {
        UserDefaults.standard.removeObject(forKey: myKey)
    }
    
}


