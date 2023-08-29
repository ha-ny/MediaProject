//
//  ProfileView.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/30.
//

import UIKit

class ProfileView: UIView, ViewSettingFuncsProtocol {
    
    let profileImage = {
        let view = UIImageView()
        view.backgroundColor = .red
        //view.image = UIImage(systemName: "person.crop.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
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
        //self.addSubViews(profileImage)
    }
    
    func constraintsView() {
//        profileImage.snp.makeConstraints { make in
//            make.top.left.equalToSuperview().offset(50)
//        }
    }
}
