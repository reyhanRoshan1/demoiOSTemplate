//
//  ViewController.swift
//  iosDemoTemplate
//
//  Created by Surinder kumar on 24/07/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

//MARK: API
extension ViewController{
    
    func userLogin(){
        UserViewModel.shared?.userLogin(email: "", password: "", completion: { [weak self] (success,msg) in
            if success{
                
            }else{
                
            }
        })
    }
    
}
