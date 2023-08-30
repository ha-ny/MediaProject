//
//  ProfileView.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/30.
//

import UIKit

class ProfileView: UIView, ViewSettingFuncsProtocol {

    let nameLabel = {
       let view = UILabel()
        view.text = "이름"
        return view
    }()
    
    let nameTextField = {
       let view = UITextField()
        view.textAlignment = .left
        view.placeholder = "이름을 입력해주세요"
        return view
    }()
    
    let nickNameLabel = {
       let view = UILabel()
        view.text = "사용자 이름"
        return view
    }()
    
    let nickNameTextField = {
       let view = UITextField()
        view.placeholder = "사용자 이름을 입력해주세요"
        return view
    }()
    
    let introduceLabel = {
       let view = UILabel()
        view.text = "소개"
        return view
    }()
    
    let introduceTextField = {
       let view = UITextField()
        view.placeholder = "인사말을 입력해주세요"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        constraintsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubViews() {
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(nickNameLabel)
        addSubview(nickNameTextField)
        addSubview(introduceLabel)
        addSubview(introduceTextField)
    }
    
    func constraintsView() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(self.safeAreaLayoutGuide).offset(25)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(nameLabel)
            make.right.equalToSuperview().inset(25)
            make.left.equalTo(nameLabel.snp.right).offset(25)
        }

        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.leading.trailing.equalTo(nameLabel)
        }

        nickNameTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(nickNameLabel)
            make.right.equalToSuperview().inset(25)
            make.left.equalTo(nickNameLabel.snp.right).offset(25)
        }

        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(25)
            make.leading.trailing.equalTo(nickNameLabel)
        }

        introduceTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(introduceLabel)
            make.right.equalToSuperview().inset(25)
            make.left.equalTo(introduceLabel.snp.right).offset(25)
        }
    }
}
