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
    }
    
    func constraintsView(){
        mediaListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
