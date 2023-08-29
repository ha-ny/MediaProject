//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/30.
//

import UIKit

class ProfileViewController: UIViewController {

    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "프로필 편집"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClick))
    }
    
    @objc func saveButtonClick(){
        
    }
}
