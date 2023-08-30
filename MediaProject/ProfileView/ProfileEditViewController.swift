//
//  ProfileEditViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/31.
//

import UIKit

class ProfileEditViewController: UIViewController, ViewSettingFuncsProtocol, ProfileDataSendProtocol {
    
    var titleText: String?
    var placeholder: String?
    
    lazy var textfield = {
        let view = UITextField()
        view.placeholder = placeholder
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = titleText
        
        addSubViews()
        constraintsView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(endEdit))
        
        let vc = ProfileViewController()
        vc.delegate = self
    }
    
    func profileEditData(title: String, placeHolder: String){
        titleText = title
        placeholder = placeHolder
    }
    
    @objc func endEdit() {
        navigationController?.popViewController(animated: true)
    }
    
    func addSubViews() {
        view.addSubview(textfield)
    }
    
    func constraintsView() {
        textfield.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }
}
