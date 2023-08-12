//
//  MediaListViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class MediaListViewController: UIViewController {

    @IBOutlet var mediaListTableView: UITableView!
    
    var mediaListArray = [MediaData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaListTableView.delegate = self
        mediaListTableView.dataSource = self
        
        let nib = UINib(nibName: MediaListTableViewCell.identifier, bundle: nil)
        mediaListTableView.register(nib, forCellReuseIdentifier: MediaListTableViewCell.identifier)
        
        DispatchQueue.global().async {
            self.apiData()
        }
    }
}

//API
extension MediaListViewController{
    func apiData() {
        
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.tmdbKey)"
        MediaInfo.mediaAPI(url: url) { json in

            for item in json["results"].arrayValue {

                let id = item["id"].stringValue
                let title = item["title"].stringValue
                let overview = item["overview"].stringValue
                let release_date = item["release_date"].stringValue
                let backdrop_path = item["backdrop_path"].stringValue
                let poster_path = item["poster_path"].stringValue
                
                self.mediaListArray.append(MediaData(id: id, title: title, overview: overview, release_date: release_date, backdrop_path: backdrop_path, poster_path: poster_path))
            }

            self.mediaListTableView.reloadData()
        }
    }
}

//UITableViewController
extension MediaListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaListTableViewCell.identifier) as? MediaListTableViewCell else { return UITableViewCell() }

        let data = mediaListArray[indexPath.row]
        cell.dateLabel.text = data.release_date
        cell.mediaTitleLabel.text = data.title
        cell.mediaOverviewLabel.text = data.overview
        
        cell.mediaImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.backdrop_path))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: MediaDetailViewController.identifier) as? MediaDetailViewController else { return }
        vc.mediaData = mediaListArray[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
    }
}
