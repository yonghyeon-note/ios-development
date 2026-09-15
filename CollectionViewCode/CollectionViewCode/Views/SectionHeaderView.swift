//
//  SectionHeaderView.swift
//  CollectionViewCode
//
//  Created by Yonghyeon Kim on 9/15/26.
//

import UIKit

final class SectionHeaderView: UICollectionReusableView {

    // MARK: - Properties

    static let identifier = "SectionHeaderView"

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        return label
    }()


    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Helpers

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(countLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.widthAnchor.constraint(equalToConstant: 180),

            countLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            countLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configure(title: String, count: Int) {
        titleLabel.text = title
        countLabel.text = "\(count)개"
    }

}
