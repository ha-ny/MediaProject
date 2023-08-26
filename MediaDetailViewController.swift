//
//  MediaDetailViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class MediaDetailViewController: UIViewController {

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

    var crewArray: [TmdbDetailData.Profile] = []
    var castArray: [TmdbDetailData.Profile] = []
    
    //MediaListViewController에서 값 넘겨줌
    var mediaData: TmdbListData.Result!
    var isOverViewDown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "출연/제작"
        allOverViewButton.addTarget(self, action: #selector(allOverViewButtonClick), for: .touchUpInside)
        
        [backImageView, overViewTitleLabel, overViewLabel, allOverViewButton, detailTableView].forEach {
            view.addSubview($0)
        }
        
        [titleLabel, posterImageView].forEach {
            backImageView.addSubview($0)
        }

        backImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.27)
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
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        let nib = UINib(nibName: MediaDetailTableViewCell.identifier, bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: MediaDetailTableViewCell.identifier)
        
        viewSetting()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.rowHeight = 100

        apiData()
    }
    
    @objc func allOverViewButtonClick() {
        if isOverViewDown{
            overViewLabel.numberOfLines = 6
            allOverViewButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            isOverViewDown = false
        }else{
            overViewLabel.numberOfLines = 0
            allOverViewButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            isOverViewDown = true
        }
    }
}

//API
extension MediaDetailViewController{
    
    func apiData() {
        
        TmdbManager.shard.callApiData(url: "https://api.themoviedb.org/3/movie/\(mediaData.id)/credits?api_key=\(APIKey.tmdbKey)") { data in

            self.crewArray = data.crew
            self.castArray = data.cast
            self.detailTableView.reloadData()
        }
    }
}

//UITableViewController
extension MediaDetailViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if crewArray.count < 1{
            return section == DetailSection.Crew.rawValue ? crewArray.count : castArray.count
        }else{
            return 10
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaDetailTableViewCell.identifier) as? MediaDetailTableViewCell else { return UITableViewCell() }

        let data = indexPath.section == DetailSection.Crew.rawValue ? crewArray[indexPath.row] : castArray[indexPath.row]
        cell.detailImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(data.profilePath ?? "")"))
        cell.detailNameLabel.text = data.name
        cell.detailOverviewLabel.text = data.character ?? data.job

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(describing: section == DetailSection.Crew.rawValue ? DetailSection.Crew : DetailSection.Cast)
    }
}

//viewSetting
extension MediaDetailViewController{
    func viewSetting() {
        guard let data = mediaData else { return }

        backImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.backdropPath))
        posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.posterPath))
        titleLabel.text = data.title
        overViewLabel.text = data.overview
    }
}
