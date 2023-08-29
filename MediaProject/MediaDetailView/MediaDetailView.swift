//
//  MediaDetailView.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/29.
//

import UIKit

class MediaDetailView: UIView, ViewSettingFuncsProtocol {
    
    let backImageView = {
        let view = UIImageView()
        view.alpha = 0.7
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.textColor = .white
        return view
    }()
    
    let posterImageView = {
        let view = UIImageView()
        view.backgroundColor = .orange
        return view
    }()
    
    let overViewTitleLabel = {
        let view = UILabel()
        view.text = "- overview"
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let overViewLabel = {
        let view = UILabel()
        view.numberOfLines = 4
        view.lineBreakMode = .byCharWrapping
        view.font = .boldSystemFont(ofSize: 13)
        return view
    }()
    
    let allOverViewButton = {
        let view = UIButton()
        view.tintColor = .gray
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return view
    }()
    
    let detailTableView = {
        let view = UITableView()
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
        
        [backImageView, overViewTitleLabel, overViewLabel, allOverViewButton, detailTableView].forEach {
            self.addSubview($0)
        }
        
        [titleLabel, posterImageView].forEach {
            backImageView.addSubview($0)
        }
    }
    
    func constraintsView(){

        backImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(self.snp.height).multipliedBy(0.27)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(10)
        }
        
//        posterImageView.snp.makeConstraints { make in
//           // make.leading.equalToSuperview()
//            ///make.top.equalTo(view.snp.bottom).offset(10)
//            make.height.equalTo(50)
//        }
   
        overViewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(backImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().offset(10)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(overViewTitleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        allOverViewButton.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom)
            make.leading.trailing.equalTo(overViewLabel)
            make.height.equalTo(35)
        }
        
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(allOverViewButton.snp.bottom).offset(4)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
