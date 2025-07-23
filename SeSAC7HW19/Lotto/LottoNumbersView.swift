//
//  LottoNumbersView.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/23/25.
//

import UIKit

class LottoNumbersView: UIView {
    let numberStack = UIStackView()

    let plusLabel = UILabel()
    let bonusBall = LottoBallView()
    let bonusText = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("스토리보드로 사용됨, 에러")
    }

    func configureRandomNumbers() {
        var numbers = (1...45).shuffled().prefix(7)
        let bonusNumber = numbers.removeLast()
        let lottoNumbers = numbers.sorted()

        lottoNumbers.forEach {
            let ball = LottoBallView()
            ball.configureNumber(number: $0)
            numberStack.addArrangedSubview(ball)
        }
        bonusBall.configureNumber(number: bonusNumber)
    }
}

extension LottoNumbersView: ViewDesignProtocol {
    func configureHierachy() {
        self.addSubview(numberStack)

        numberStack.addArrangedSubview(plusLabel)
        numberStack.addArrangedSubview(bonusBall)
        numberStack.addArrangedSubview(bonusText)
    }
    
    func configureLayout() {
        numberStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureView() {
        numberStack.axis = .horizontal
        numberStack.spacing = 4

        plusLabel.text = "+"
        plusLabel.font = .systemFont(ofSize: 18, weight: .bold)

        bonusText.text = "보너스"
        bonusText.font = .systemFont(ofSize: 13, weight: .semibold)
        bonusText.textColor = .customGray
    }
    

}
