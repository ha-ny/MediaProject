//
//  MediaListViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class MediaListViewController: UIViewController {
    
    let mediaListTableView = {
        let view = UITableView()
        view.separatorStyle = .none
        return view
    }()

    var mediaListArray: TmdbListData.MovieListData = TmdbListData.MovieListData(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MOVIE"
        view.backgroundColor = .white
        view.addSubview(mediaListTableView)
        mediaListTableView.delegate = self
        mediaListTableView.dataSource = self

        mediaListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let nib = UINib(nibName: MediaListTableViewCell.identifier, bundle: nil)
        mediaListTableView.register(nib, forCellReuseIdentifier: MediaListTableViewCell.identifier)
        
        apiData()
    }
}

//API
extension MediaListViewController{
    func apiData() {
        
        TmdbManager.shard.callApiData(url: "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.tmdbKey)") { data in

            self.mediaListArray = data
            self.mediaListTableView.reloadData()
        }
    }
}

//UITableViewController
extension MediaListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaListArray.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaListTableViewCell.identifier) as? MediaListTableViewCell else { return UITableViewCell() }

        let data = mediaListArray.results[indexPath.row]
        cell.dateLabel.text = data.releaseDate
        cell.mediaTitleLabel.text = data.title
        cell.mediaOrginalTitleLabel.text = "(\(data.original_title))"
        cell.mediaOverviewLabel.text = data.overview
        
        cell.mediaImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/" + data.backdropPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MediaDetailViewController()
        vc.mediaData = mediaListArray.results[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
