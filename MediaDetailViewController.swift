//
//  MediaDetailViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class MediaDetailViewController: UIViewController {

    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var allOverViewButton: UIButton!
    
    var crewArray: [ProfileData] = []
    var castArray: [ProfileData] = []
    
    //MediaListViewController에서 값 넘겨줌
    var mediaData: MediaData?
    var isOverViewDown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: MediaDetailTableViewCell.identifier, bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: MediaDetailTableViewCell.identifier)
        
        viewSetting()
        title = "출연 / 제작"
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.rowHeight = 100
        
        DispatchQueue.global().async {
            self.apiData()
        }
    }
    
    @IBAction func allOverViewButtonClick(_ sender: Any) {
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
        
        let url = "https://api.themoviedb.org/3/movie/\(mediaData?.id ?? "")/credits?api_key=\(APIKey.tmdbKey)"
        MediaInfo.mediaAPI(url: url) { json in
            var profileImage = String()
            var name = String()
            var overview = String()
            
            let crew = json["crew"].arrayValue[0...10]
            for item in crew{

                profileImage = item["profile_path"].stringValue
                name = item["name"].stringValue
                overview = item["department"].stringValue

                self.crewArray.append(ProfileData(profileImage: profileImage, name: name, overview: overview))
            }
            
            let cast = json["cast"].arrayValue[0...10]
            for item in cast {

                profileImage = item["profile_path"].stringValue
                name = item["name"].stringValue
                overview = item["character"].stringValue

                self.castArray.append(ProfileData(profileImage: profileImage, name: name, overview: overview))
            }

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
        
        return section == DetailSection.Crew.rawValue ? crewArray.count : castArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaDetailTableViewCell.identifier) as? MediaDetailTableViewCell else { return UITableViewCell() }

        let data = indexPath.section == DetailSection.Crew.rawValue ? crewArray[indexPath.row] : castArray[indexPath.row]
        print()
        cell.detailImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.profileImage))
        cell.detailNameLabel.text = data.name
        cell.detailOverviewLabel.text = data.overview

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
        
        backImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.backdrop_path))
        posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.poster_path))
        titleLabel.text = data.title
        overViewLabel.text = data.overview
    }
}
