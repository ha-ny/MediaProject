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

    let mainView = MediaDetailView()
    
    var crewArray: [TmdbDetailData.Profile] = []
    var castArray: [TmdbDetailData.Profile] = []
    
    //MediaListViewController에서 값 넘겨줌
    var mediaData: TmdbListData.Result!
    var isOverViewDown = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "출연/제작"
        mainView.allOverViewButton.addTarget(self, action: #selector(allOverViewButtonClick), for: .touchUpInside)
        
        let nib = UINib(nibName: MediaDetailTableViewCell.identifier, bundle: nil)
        mainView.detailTableView.register(nib, forCellReuseIdentifier: MediaDetailTableViewCell.identifier)
        
        viewSetting()
        mainView.detailTableView.delegate = self
        mainView.detailTableView.dataSource = self
        mainView.detailTableView.rowHeight = 100

        apiData()
    }
    
    @objc func allOverViewButtonClick() {
        if isOverViewDown{
            mainView.overViewLabel.numberOfLines = 6
            mainView.allOverViewButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            isOverViewDown = false
        }else{
            mainView.overViewLabel.numberOfLines = 0
            mainView.allOverViewButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
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
            self.mainView.detailTableView.reloadData()
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

        mainView.backImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.backdropPath))
        mainView.posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.posterPath))
        mainView.titleLabel.text = data.title
        mainView.overViewLabel.text = data.overview
    }
}
