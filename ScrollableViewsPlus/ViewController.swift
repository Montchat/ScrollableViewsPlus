//
//  ViewController.swift
//  ScrollableViewsTemplate
//
//  Created by Joe E. on 3/8/16.
//  Copyright © 2016 Joe Edwards. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //* use xib files to customize how you want the ui for each screen to work
    
    //adding our three default viewControllers to our scrollView
    let vc1 = VC1(nibName: "VC1", bundle: nil) ; let vc2 = VC2(nibName: "VC2", bundle: nil) ; let vc3 = VC3(nibName: "VC3", bundle: nil)
    
    var label = UILabel() ; var label2 = UILabel() ; var label3 = UILabel()
    
    var leftGestureRecognizer = UISwipeGestureRecognizer() //adding ability to be able to do stuff if you want to swipe. you can get creative with this
    var rightGestureRecognizer = UISwipeGestureRecognizer()

    @IBOutlet weak var scrollView: UIScrollView!
    
    func leftSwipe(swipe:UISwipeGestureRecognizer) {
        if swipe.direction == .Left {
            //do a basic animation

        }
        
        if swipe.state == .Ended {
            
            UIView.animateWithDuration(0.33, animations: { () -> Void in
                self.label3.center.x = self.view.center.x
                self.label.center.x = self.label3.frame.minX - 50
                self.label2.center.x = self.label.frame.minX - 50
                
            })
            
        }
        
    }
    
    func rightSwipe(swipe:UISwipeGestureRecognizer) {
        if swipe.direction == .Right {
            //do a basic animation

        }
        
        if swipe.state == .Ended {
            UIView.animateWithDuration(0.33, animations: { () -> Void in
                self.label2.center.x = self.view.center.x
                self.label.center.x = self.label2.frame.maxX + 50
                self.label3.center.x = self.label.frame.maxX + 50
                
            })
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftGestureRecognizer.addTarget(self, action: "leftSwipe:") ; rightGestureRecognizer.addTarget(self, action: "rightSwipe:")
        leftGestureRecognizer.direction = .Left ; rightGestureRecognizer.direction = .Right
    
        scrollView.addGestureRecognizer(leftGestureRecognizer) ; scrollView.addGestureRecognizer(rightGestureRecognizer)
        
        //first we need to add a blurView above the scroll view so that it looks like a menu
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark) ; let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 60)
        view.addSubview(blurEffectView)
        
        //then we need to add a label to display what page the user is currently on
        label = UILabel(frame: CGRect(x: 0, y: blurEffectView.bounds.midY, width: 50, height: 30)) ; label.text = vc2.name ; label.font = UIFont.systemFontOfSize(12, weight: UIFontWeightMedium)
        label.textColor = UIColor.whiteColor() ; label.textAlignment = .Center ; label.center.x = blurEffectView.center.x
        blurEffectView.addSubview(label)
        
        label2 = UILabel(frame: CGRect(x: 0, y: blurEffectView.bounds.midY, width: 50, height: 30)) ; label2.text = vc1.name ; label2.font = UIFont.systemFontOfSize(12, weight: UIFontWeightMedium)
        label2.textColor = UIColor.whiteColor() ; label2.textAlignment = .Center ; label2.center.x = label.frame.minX - 50 ; label2.alpha = 0.33
        blurEffectView.addSubview(label2)
        
        label3 = UILabel(frame: CGRect(x: 0, y: blurEffectView.bounds.midY, width: 50, height: 30)) ; label3.text = vc3.name ; label3.font = UIFont.systemFontOfSize(12, weight: UIFontWeightMedium)
        label3.textColor = UIColor.whiteColor() ; label3.textAlignment = .Center ; label3.center.x = label.frame.maxX + 50 ; label3.alpha = 0.33
        blurEffectView.addSubview(label3)
        
        let leftSide = UIView(frame: view.frame) ; let rightSide = UIView(frame: view.frame)
        
        leftSide.frame.origin = view.frame.origin ; leftSide.backgroundColor = vc1.view.backgroundColor
        rightSide.frame.origin.x = view.frame.midX ; rightSide.backgroundColor = vc3.view.backgroundColor
        
        view.addSubview(leftSide); view.addSubview(rightSide)
        
        scrollView.addSubview(vc1.view) ; scrollView.addSubview(vc2.view) ; scrollView.addSubview(vc3.view)
        view.bringSubviewToFront(scrollView) ; view.bringSubviewToFront(blurEffectView)
        
        vc2.view.frame.origin.x = view.frame.width ; vc3.view.frame.origin.x = view.frame.width * 2
        
        //Adjusting the size of the scrollViews
        scrollView.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
        //Set the views so that the main view is in the middle and the login and signUp are on the left and right respectively.
        scrollView.setContentOffset(vc2.view.frame.origin, animated: false)
        
        //Setting the delegates of the GestureRecoginzers above
        leftGestureRecognizer.delegate = self ; rightGestureRecognizer.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
