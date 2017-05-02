//
//  ImageShadowView.swift
//  ImageShadowMakerSwift
//
//  Created by 厉国辉 on 2017/4/28.
//  Copyright © 2017年 GofeyLee. All rights reserved.
//

import UIKit

class ImageShadowView: UIView {

    public var image:UIImage? {
        didSet{
            
            self.imgView?.image = image
            
        }
    }
    
    public var shadowRadius:CGFloat? {
        didSet{
            self.layer.shadowRadius = shadowRadius!
        }
    }
    
    public var cornerRadius:CGFloat? {
        didSet{
            self.imgView?.clipsToBounds = true
            self.imgView?.layer.cornerRadius = cornerRadius!
        }
    }
    
    public var shadowOffset:CGSize? {
        didSet{
            self.layer.shadowOffset = shadowOffset!
        }
    }
    
    private var imgView:UIImageView?
    
    override var contentMode: UIViewContentMode{
        set{
            super.contentMode = newValue
            self.imgView?.contentMode = newValue
        }
        get{
            return super.contentMode
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(imgView!)
        imgView?.isUserInteractionEnabled = true
    }
    
    private func shadow() {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
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

//MARK: - UIImage  extension
extension UIImage {
    var mostColor:UIColor {
        // 获取图片信息
        
//        let imgCGImage = self.cgImage
        let imgWidth:Int = Int(self.size.width) / 2
        let imgHeight:Int = Int(self.size.height) / 2
        
        // 位图的大小 ＝ 图片宽 ＊ 图片高 ＊ 图片中每点包含的信息量
        let bitmapByteCount = imgWidth * imgHeight * 4
        
        // 使用系统的颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 根据位图大小，申请内存空间
        let bitmapData = malloc(bitmapByteCount)
        defer {free(bitmapData)}
        
        // 创建一个位图
        let context = CGContext(data: bitmapData,
                                width: imgWidth,
                                height: imgHeight,
                                bitsPerComponent: 8,
                                bytesPerRow: imgWidth * 4,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        // 图片的rect
        let rect = CGRect(x: 0, y: 0, width: CGFloat(imgWidth), height: CGFloat(imgHeight))
        // 将图片画到位图中
        context?.draw(self.cgImage!, in: rect)
        
        // 获取位图数据
        let bitData = context?.data
        let data = unsafeBitCast(bitData, to: UnsafePointer<CUnsignedChar>.self)
 
        let cls = NSCountedSet.init(capacity: imgWidth * imgHeight)
        for x in 0..<imgWidth {
            for y in 0..<imgHeight {
                let offSet = (y * imgWidth + x) * 4
                let r = (data + offSet    ).pointee
                let g = (data + offSet + 1).pointee
                let b = (data + offSet + 2).pointee
                let a = (data + offSet + 3).pointee
                if a > 0 {
                    //去除透明
                    if !(r == 255 && g == 255 && b == 255) {
                        //去除白色
                        cls.add([CGFloat(r), CGFloat(g), CGFloat(b), CGFloat(a)])
                    }
                }
                
            }
        }
        
        //找到出现次数最多的颜色
        let enumerator = cls.objectEnumerator()
        var maxColor:Array<CGFloat>? = nil
        var maxCount = 0
        while let curColor = enumerator.nextObject() {
            let tmpCount = cls.count(for: curColor)
            if tmpCount >= maxCount{
                maxCount = tmpCount
                maxColor = curColor as? Array<CGFloat>
            }
        }
        return UIColor.init(red: (maxColor![0] / 255), green: (maxColor![1] / 255), blue: (maxColor![2] / 255), alpha: (maxColor![3] / 255))
    }
   
}
