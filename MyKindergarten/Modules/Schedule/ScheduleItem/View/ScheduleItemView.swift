//
//  ScheduleItemView.swift
//  MyKindergarten
//
//  Created by Headdds and hands on 27.05.2022.
//

import AutoLayoutSugar
import UIKit

final class ScheduleItemView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        makeConstraints()   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {}
    
    private func makeConstraints() {}
}
