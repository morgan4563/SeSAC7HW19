//
//  BoxOfficeViewController.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/23/25.
//

import UIKit
import SnapKit

class BoxOfficeViewController: UIViewController {
    var movie = MovieInfo.movies.shuffled().prefix(10)

    let backgroundImage = UIImageView()
    let searchTextField = UITextField()
    let bottomLine = UIView()
    let searchButton = UIButton()
    let movieTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierachy()
        configureLayout()
        configureView()
    }

}

extension BoxOfficeViewController: ViewDesignProtocol {
    func configureHierachy() {
        view.addSubview(backgroundImage)
        view.addSubview(searchTextField)
        view.addSubview(bottomLine)
        view.addSubview(searchButton)
        view.addSubview(movieTableView)
    }
    
    func configureLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalTo(searchButton.snp.leading).offset(-16)
            make.height.equalTo(44)
        }
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.horizontalEdges.equalTo(searchTextField)
            make.height.equalTo(2)
        }
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        backgroundImage.image = UIImage(named: "freepik_movieBackground")
        backgroundImage.alpha = 0.3
        backgroundImage.contentMode = .scaleAspectFill

        searchTextField.textColor = .white

        bottomLine.backgroundColor = .white

        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = .white

        movieTableView.backgroundColor = .clear

        movieTableView.delegate = self
        movieTableView.dataSource = self

        movieTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)

        searchTextField.delegate = self
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as! BoxOfficeTableViewCell

        cell.indexLabel.text = "\(indexPath.row + 1)"
        cell.titleLabel.text = movie[indexPath.row].title
        cell.dateLabel.text = movie[indexPath.row].releaseDate
        cell.backgroundColor = .clear

        return cell
    }
}

extension BoxOfficeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        movie = MovieInfo.movies.shuffled().prefix(10)
        movieTableView.reloadData()
        return true
    }
}
