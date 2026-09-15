//
//  ViewController.swift
//  CollectionViewCode
//
//  Created by Yonghyeon Kim on 9/15/26.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties

    private let colors: [UIColor] = [
        .systemRed, .systemBlue, .systemGreen, .systemYellow,
        .systemPurple, .systemOrange, .systemPink, .systemTeal,
        .systemIndigo, .systemBrown, .systemGray, .systemCyan
    ]

    private struct Section {
        let title: String
        let items: [UIColor]
    }

    private var sections: [Section] = []

    private let colorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupCollectionView()
        setupSections()
    }


    // MARK: - Helpers

    private func setupCollectionView() {
        view.addSubview(colorCollectionView)

        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self

        colorCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        colorCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

        colorCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            colorCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colorCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            colorCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            colorCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupSections() {
        sections = [
            Section(title: "첫 번째", items: colors),
            Section(title: "두 번째", items: colors),
            Section(title: "세 번째", items: colors)
        ]
    }

}


// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {

    /* numberOfSections */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    /* numberOfItemsInSection */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    /* cellForItemAt */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        cell.backgroundColor = colors[indexPath.item % colors.count]
        cell.layer.cornerRadius = 8

        return cell
    }

    /* viewForSupplementaryElementOfKind */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView

            let section = sections[indexPath.section]

            header.configure(title: section.title, count: section.items.count)

            return header
        }

        return UICollectionReusableView()
    }

}


// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {

    /* didSelectItemAt */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedColor = colors[indexPath.item % colors.count]
        print("선택된 색상: \(selectedColor)")

        if let cell = collectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    cell.transform = .identity
                }
            }
        }
    }

}


// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {

    /* sizeForItemAt */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
        let spacing: CGFloat = 10
        let totalSpacing = spacing * (numberOfColumns - 1) + spacing * 2
        let width = floor((collectionView.bounds.width - totalSpacing) / numberOfColumns)
        let itemSize = CGSize(width: width, height: width)
        return itemSize
    }

    /* insetForSectionAt */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    /* minimumLineSpacingForSectionAt */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    /* minimumInteritemSpacingForSectionAt */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    /* referenceSizeForHeaderInSection */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

}
