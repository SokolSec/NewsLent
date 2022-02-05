//
//  TableViewControllerbyNews.swift
//  News
//
//  Created by Даниил Сокол on 05.02.2022.
//

import UIKit

class TableViewControllerbyNewsModel {
    let title : String
    let subtitle : String
    
    init(title : String, subtitle : String)
    {
        self.title = title
        self.subtitle = subtitle
    }
}

class TableViewControllerbyNews: UITableViewCell {

    static let identifier = "TableViewControllerbyNews"
    private let newsTitleLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20, weight: .medium)
        return lable
    }()
    
    private let subtitleLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14, weight: .regular)
        return lable
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLable)
        contentView.addSubview(subtitleLable)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews (){
        super.layoutSubviews()
        
        newsTitleLable.frame = CGRect(x: 9, y: 0, width: contentView.frame.size.width, height: 70)
        
        subtitleLable.frame = CGRect(x: 9, y: 40, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    override func prepareForReuse(){
        super.prepareForReuse()
    }
    func configure(with viewModel: TableViewControllerbyNewsModel){
        newsTitleLable.text = viewModel.title
        subtitleLable.text = viewModel.subtitle
    }
}
