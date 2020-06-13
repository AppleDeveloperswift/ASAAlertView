//
//  ASAAlert.swift
//  pop
//
//  Created by Apple on 2020/6/5.
//  Copyright © 2020 Apple. All rights reserved.
//
import UIKit
// MARK: -面向协议开发
let color1 = UIColor.init(displayP3Red: 0.8, green: 0.616, blue: 0.69, alpha: 1)
let color2 = UIColor.init(displayP3Red: 0.749 , green: 0.91, blue: 0.525, alpha: 1)
enum ActionPosition {
    case blue
    case orange
    case pick
    case color2
}
class ASAAlert: UIView {
    typealias clickAlert = (_ index: Int) -> Void
    var clickAction: (() -> ())?
    private func Action() -> Void {
        if let _catg = clickAction {
            _catg()
        }
    }
    var clickClosure:clickAlert?
    func clickIndex(_ closure:@escaping clickAlert){
    clickClosure = closure
    }
    var popimage: String
    var alphagh: CGFloat
    var color: UIColor
    let text = UITextView()
    let bgView = UIView()
    let bgView2 = UIView()
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let titleLabel = UILabel()
    var title = ""
    let sureBt = UIButton()
    let cancelBt = UIButton()
    let Bgtap = UITapGestureRecognizer()
    init(title: String?, message: String?, sureButtonTitle: String?, cancelButtonTitle: String?, bgalpha: CGFloat,imagename: String, colortype: ActionPosition) {
        self.popimage = imagename
        self.alphagh = bgalpha
        switch colortype {
        case .blue:
            self.color = UIColor.blue
            break
        case .orange:
            self.color = UIColor.orange
            break
        case .pick:
            self.color = color1
            break
        case .color2:
            self.color = color2
        default:
            self.color = UIColor.purple
            break
        }
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        createAlertView()
        self.text.text = message
        self.titleLabel.text = title
        self.sureBt.setTitle(sureButtonTitle, for: .normal)
        self.cancelBt.setTitle(cancelButtonTitle, for: .normal)
    }
    //MARK:- 调用，协议
    func createAlertView() {
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        Bgtap.addTarget(self, action: #selector(ASAAlert.dismiss))
        self.addGestureRecognizer(Bgtap)
        bgView.frame = CGRect(x: 30, y: height/2 - 155, width: width - 60, height: 270)//h:195
        bgView.backgroundColor = color
        bgView.alpha = alphagh
        bgView.layer.cornerRadius = 9
        bgView.clipsToBounds = true
        self.addSubview(bgView)
        let Bgwidth = bgView.frame.size.width
        let Bgheight = bgView.frame.size.height
        titleLabel.frame = CGRect(x: 40, y: 70, width: Bgwidth - 90, height: 10 )
        titleLabel.textColor = UIColor.green
        titleLabel.textAlignment = .center
        
        sureBt.frame = CGRect(x: 5, y: Bgwidth - 35 , width: 105, height: 40)
        sureBt.backgroundColor = UIColor.yellow
        sureBt.layer.cornerRadius = 7
        sureBt.clipsToBounds = true
        sureBt.tag = 2
        sureBt.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(sureBt)
        cancelBt.frame = CGRect(x: 150, y: Bgwidth - 35 , width: 105, height: 40)
        cancelBt.backgroundColor = UIColor.gray
        cancelBt.layer.cornerRadius = 7
        cancelBt.tag = 1
        cancelBt.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(cancelBt)
        text.frame = CGRect(x: 30, y: 85, width: 200, height: 110)//width: 200
        text.backgroundColor = UIColor.clear
        text.font = UIFont.systemFont(ofSize: 16)
        text.layer.borderColor = UIColor.green.cgColor
        text.layer.borderWidth = 1.5
        bgView.addSubview(text)
        bgView2.frame = CGRect(x: 105.3, y: 75, width: 115, height: 115)//100 110 85
        bgView2.backgroundColor = color
        bgView2.alpha = alphagh
        bgView2.clipsToBounds = true
        bgView2.contentMode = .scaleAspectFill
        bgView2.layer.cornerRadius = bgView2.frame.width/2
        let image = UIImage(named: popimage)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 7, y: 7, width: 100, height: 100)//透明度
        imageView.layer.masksToBounds = true
        imageView.alpha = 1
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width/2
        self.addSubview(bgView2)
        bgView2.addSubview(imageView)
        bgView.addSubview(titleLabel)
    }
    @objc func clickBtnAction(_ sender: UIButton) {
        if (clickClosure != nil) {
            clickClosure!(sender.tag)
            if sender.tag == 1 {
               dismiss()
            }else{
                Action()
            }
        }
    }
    @objc func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {() -> Void in
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }
    func show() {
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        wind?.addSubview(self)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 8, options: [], animations: {
            self.bgView.center.y -= 40
            self.bgView2.center.y -= 40
            self.alpha = 1
        }, completion: nil)
    }

    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
