//
//  MediaListView.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/29.
//

import UIKit

class MediaListView: UIView, ViewSettingFuncsProtocol{

    let mediaListTableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()
    
    let profileButton = {
        let view = UIButton()
        let image = UIImage(systemName: "person.crop.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        view.setImage(image, for: .normal)
        view.tintColor = .darkGray
        view.backgroundColor = .black
        view.layer.cornerRadius = 38
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
    
    func addSubViews(){
        self.addSubview(mediaListTableView)
        self.addSubview(profileButton)
    }
    
    func constraintsView(){
        
        mediaListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(20)
        }
    }
}
