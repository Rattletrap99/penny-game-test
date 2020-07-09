//
//  CustomButton.swift
//  Coin Portfolio
//
//  Created by Developer on 11/17/19.
//  Copyright © 2019 com.TDJDeveloper. All rights reserved.
//

import UIKit
import AVFoundation


class CustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor.lightGray, for: .normal)
        layer.cornerRadius = 10
        backgroundColor = UIColor.red
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

class CustomButtonGreen: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor.blue, for: .normal)
        layer.cornerRadius = 10
        self.titleLabel!.numberOfLines = 2 // Dynamic number of lines
        self.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.titleLabel!.textAlignment = .center

        backgroundColor = UIColor.green
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

class CustomButtonBlue: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor.lightGray, for: .normal)
        layer.cornerRadius = 10
        backgroundColor = UIColor.blue
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

class CustomButtonOrange: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        setTitleColor(UIColor.lightGray, for: .normal)
        layer.cornerRadius = 10
        backgroundColor = UIColor.orange
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            self.alpha = 0.0
            
        }, completion: nil)

    }
}

class CustomButtonPurple: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor.lightGray, for: .normal)
        layer.cornerRadius = 10
        
        
        
        let myColor = UIColor(red: 0.933, green: 0.039, blue: 0.969, alpha: 1.00)
        backgroundColor = myColor
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}



class CustomButtonLime: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleColor(UIColor.lightGray, for: .normal)
        layer.cornerRadius = 10
        let myColor = UIColor(red: 0.732, green: 1.000, blue: 0.001, alpha: 1.00)
        backgroundColor = myColor
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

// Plain buttons


class CoolButtonPurple: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteTextColor = UIColor.white
        setTitleColor(whiteTextColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
//        if self.isSelected {
//            AudioServicesPlayAlertSound(SystemSoundID(1306))
//        }

//        layer.cornerRadius = 10
        backgroundColor = UIColor.clear
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
}


class CoolButtonBlue: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteTextColor = UIColor.white
        setTitleColor(whiteTextColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
//        layer.cornerRadius = 10
        backgroundColor = UIColor.clear
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
        
//        if self.isSelected {
//            AudioServicesPlayAlertSound(SystemSoundID(1306))
//        }

    }
}

class CoolButtonRed: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteTextColor = UIColor.white
        setTitleColor(whiteTextColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
//        layer.cornerRadius = 10
        backgroundColor = UIColor.clear
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
//        if self.isSelected {
//            AudioServicesPlayAlertSound(SystemSoundID(1306))
//        }

    }
}

class CoolButtonGreen: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteTextColor = UIColor.white
        setTitleColor(whiteTextColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 4
//        layer.cornerRadius = 10
        backgroundColor = UIColor.clear
        layer.borderWidth = 2.0
        layer.borderColor = UIColor(red: 0.707, green: 0.699, blue: 0.852, alpha: 1.00).cgColor
        self.titleLabel!.textAlignment = .center
    }
}

class CoolButtonYellow: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteTextColor = UIColor.white
        setTitleColor(whiteTextColor, for: .normal)
        self.layer.cornerRadius = self.frame.height / 2
        backgroundColor = UIColor.clear
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
//        if self.isSelected {
//            AudioServicesPlayAlertSound(SystemSoundID(1306))
//        }

    }
}


class CoolButtonClear: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let whiteTextColor = UIColor.white
        setTitleColor(whiteTextColor, for: .normal)
        backgroundColor = UIColor.clear
        self.layer.cornerRadius = 20
//        if self.isSelected {
//            AudioServicesPlayAlertSound(SystemSoundID(1306))
//        }

        

        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor
        titleLabel?.numberOfLines = 0 // Dynamic number of lines
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = .center
        //        titleLabel?.attributedText
        
    }
}


class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

class myLabel : UILabel {
    override var text: String? {
        didSet {
            if text != nil {
                textColor = UIColor.red
            } else {
                textColor = UIColor.lightGray
            }
        }
    }
}

class ClearPicButton: UIButton {
    
    private (set) var numberOfTouches: Int = 0 {
        didSet {
            if self.numberOfTouches >= 2 {
                self.isEnabled = false
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.numberOfTouches += 1
    }
    
}

class CoolButtonLeftFront: UIButton {
    
    override func awakeFromNib() {
        
        let myColor = UIColor(red: 0.803, green: 0.770, blue: 0.954, alpha: 1.00)

        
        super.awakeFromNib()
//        let myColor = UIColor(red: 0.997, green: 0.029, blue: 0.523, alpha: 1.00)
        setTitleColor(myColor, for: .normal)
        self.layer.cornerRadius = 20
        titleLabel?.numberOfLines = 0 // Dynamic number of lines
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = .center
        backgroundColor = UIColor.clear
        layer.borderWidth = 3.0
        layer.borderColor = myColor.cgColor
//        if self.isSelected {
//            AudioServicesPlayAlertSound(SystemSoundID(1306))
//        }

    }
}

class CoolButtonRightFront: UIButton {
    
    let whiteTextColorColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let myColor = UIColor(red: 0.803, green: 0.770, blue: 0.954, alpha: 1.00)
        setTitleColor(myColor, for: .normal)
        self.layer.cornerRadius = 20
        titleLabel?.numberOfLines = 0 // Dynamic number of lines
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = .center
        backgroundColor = UIColor.clear
        layer.borderWidth = 3.0
        layer.borderColor = myColor.cgColor
        if self.isTouchInside {
            AudioServicesPlayAlertSound(SystemSoundID(1306))
        }
//        if self.isTouchInside {
//            <#code#>
//        }

    }
}

class RoundedView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


//extension UIColor{
//
//    static let whiteTextColor = UIColor.white
//
//
//}
