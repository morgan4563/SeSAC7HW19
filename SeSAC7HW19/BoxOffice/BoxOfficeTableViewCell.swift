//
//  BoxOfficeTableViewCell.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/24/25.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {

	static let identifier = "BoxOfficeTableViewCell"

    let rank = UILabel()
    let titleLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureHierachy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BoxOfficeTableViewCell: ViewDesignProtocol {
    func configureHierachy() {
        contentView.addSubview(rank)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        rank.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalTo(contentView)
            make.height.equalTo(22)
            make.width.equalTo(44)

        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(rank.snp.trailing).offset(16)
            make.trailing.equalTo(dateLabel.snp.leading).offset(-16)
            make.centerY.equalTo(contentView)
        }
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalTo(contentView)
        }
        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func configureView() {
        rank.backgroundColor = .white
        rank.textColor = .black
        rank.font = .systemFont(ofSize: 17, weight: .bold)
        rank.textAlignment = .center

        titleLabel.text = "엽문 4: 더 파이널"
        titleLabel.textColor = .white

        dateLabel.text = "2020-04-01"
        dateLabel.textColor = .white
    }
}
