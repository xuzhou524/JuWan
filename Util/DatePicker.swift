//
//  DatePicker.swift
//  FanZhe
//
//  Created by fanzhe on 2020/11/17.
//

import UIKit

class DatePicker: UIView {
        
    var completion:((Date?) -> Void)?
    
    let cancelButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor(named: "color_title_black"), for: .normal)
        btn.titleLabel?.font = fontWithSize(16)
        btn.setImage(UIImage(named: ""), for: .normal)
        return btn
    }()

    let doneButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor(named: "color_title_black"), for: .normal)
        btn.titleLabel?.font = fontWithSize(16)
        return btn
    }()

    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = fontWithSize(16)
        label.textColor = UIColor(named: "color_title_black")
        label.text = "选择时间"
        return label
    }()
    
    let datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        return datePicker
    }()
    
    var date:Date? {
        set{
            self.datePicker.date = newValue ?? Date()
        }
        get {
            return self.datePicker.date
        }
    }
    
    let panel:UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: 254))
        self.backgroundColor = UIColor.white
        
        self.addSubview(cancelButton)
        self.addSubview(doneButton)
        self.addSubview(titleLabel)
        
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(10)
        }
        doneButton.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.equalTo(10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(cancelButton)
        }
        
        self.addSubview(datePicker)
        datePicker.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(212)
        }
        
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        panel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancel)))
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancel() {
        hide()
    }
    
    @objc func done() {
        completion?(self.datePicker.date)
        hide()
    }

    func show(){
        
        Client.shared.mainWindow.addSubview(panel)
        Client.shared.mainWindow.addSubview(self)
        panel.alpha = 0
        self.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: 254)
        UIView.animate(withDuration: 0.3) {
            self.panel.alpha = 1
            self.frame = CGRect(x: 0, y: kScreenHeight - 254, width: kScreenWidth, height: 254)
        }
        
    }
    func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.panel.alpha = 0
            self.frame = CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: 254)
        }) { (_) in
            self.panel.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}
