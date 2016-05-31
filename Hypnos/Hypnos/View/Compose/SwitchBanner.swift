//
//  SwitchBanner.swift
//  Hypnos
//
//  Created by Maru on 16/5/24.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class SwitchBanner: UIView {

    
    /// 当前选中的位置
    var selectedIndex: Int
    /// 普通状态下的颜色
    var defaultColor: UIColor
    /// 选中状态下的颜色
    var selectedColor: UIColor
    
    private var titles: [String] {
        didSet {
            resetLayout()
        }
    }
    
    private var scrollView: UIScrollView?
    private var indexChange: ((index: Int) -> ())?
    private var items: [UIButton] = []
    private var duration: NSTimeInterval
    private var banner_context = 0
    dynamic private var line: UIImageView

    
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        self.selectedIndex = 0
        self.selectedColor = UIColor(r: 128, g: 191, b: 232, alpha: 1)
        self.defaultColor = UIColor.lightGrayColor()
        self.duration = 0.4
        self.line = UIImageView(image: UIImage(named: "heart_nav_line"))
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.resetLayout()
        addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
}

extension SwitchBanner {
    // MARK: - Public Method
    
    func configIndexMotion(motion: (index: Int) -> ()) {
        indexChange = motion
    }
    
    func configBindingScrollView(scrollView: UIScrollView) {
        self.scrollView = scrollView
        self.scrollView!.delegate = self
        self.scrollView!.addObserver(self, forKeyPath: "contentOffset", options: .New, context: &banner_context)
    }
}

extension SwitchBanner {
    
    // MARK: - Private Method
    private func resetLayout() {
        
        self.selectedIndex = 0
        
        let _ = items.map({ $0.removeFromSuperview() })
        items.removeAll()
        
        let width = frame.width / CGFloat(titles.count)
        for (index,title) in titles.enumerate() {
            let btn = UIButton(frame: CGRectMake(CGFloat(index) * width, 0, width, frame.height))
            btn.adjustsImageWhenHighlighted = false
            btn.setTitle(title, forState: .Normal)
            btn.setTitleColor(defaultColor, forState: .Normal)
            btn.setTitleColor(selectedColor, forState: .Selected)
            btn.addTarget(self, action: #selector(self.itemClick), forControlEvents: .TouchUpInside)
            btn.tag = index
            addSubview(btn)
            items.append(btn)
            if index == 0 { btn.selected = true }
        }
        line.bounds = CGRectMake(0, 0, 100, 2)
        line.center = CGPointMake(items[selectedIndex].center.x, frame.height - 1)
    }
    
    @objc private func itemClick(button: UIButton) {

        if let scroll = scrollView {
            scroll.setContentOffset(CGPointMake(self.frame.width * CGFloat(button.tag), 0), animated: true)
        }
        
        if let change = indexChange {
            change(index: button.tag)
        }
    }
    
    
}

extension SwitchBanner: UIScrollViewDelegate {
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &banner_context {
            dispatch_async(dispatch_get_main_queue()) {
                self.items[self.selectedIndex].selected = false
                let scale = CGFloat(self.items.count);
                self.line.center = CGPointMake(self.items[0].center.x + self.scrollView!.contentOffset.x / scale, self.frame.height - 1)
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        dispatch_async(dispatch_get_main_queue()) {
            self.selectedIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
            self.items[self.selectedIndex].selected = true
        }
    }
    
}


