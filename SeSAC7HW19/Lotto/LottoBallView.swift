//
//  LottoBallView.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/23/25.
//

import UIKit
import SnapKit

class LottoBallView: UIView {
    let numberBackground = UIView()
	let numberLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("스토리보드로 진행됨 에러")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        numberBackground.layer.cornerRadius = min(self.bounds.width, self.bounds.height) / 2
        numberBackground.clipsToBounds = true
    }

    func configureNumber(number: Int) {
        numberLabel.text = "\(number)"
        numberBackground.backgroundColor = color(number: number)
    }

    private func color(number: Int) -> UIColor {
        switch number {
        case 1...9:
            return .customYellow
        case 10...19:
            return .customBlue
        case 20...29:
            return .customRed
        default:
            return .customGray
        }
    }
}

extension LottoBallView: ViewDesignProtocol {
    func configureHierachy() {
        self.addSubview(numberBackground)
        numberBackground.addSubview(numberLabel)
    }
    
    func configureLayout() {
        numberBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        numberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureView() {
        numberLabel.textColor = .white
    }
}
