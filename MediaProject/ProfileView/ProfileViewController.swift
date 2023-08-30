//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/30.
//

import UIKit

class ProfileViewController: UIViewController {

    //Delegate, Closure, Notification
    let mainView = ProfileView()
    var delegate: ProfileDataSendProtocol?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "프로필 편집"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonClick))
        
        mainView.nameTextField.addTarget(self, action: #selector(viewChange), for: .touchDown)
    }
    
    @objc func viewChange(sender: UITextField) {
        
        //if ProfileList.TextFieldTag(rawValue: sender.tag) {}
        if let value = ProfileList.TextFieldTag(rawValue: sender.tag), let data = ProfileList.ProfileTextField[value]{
            delegate?.profileEditData(title: data.title, placeHolder: data.placeHolder)

            navigationController?.pushViewController(ProfileEditViewController(), animated: true)
        }
    }
    
    @objc func saveButtonClick(){
        
    }
}
