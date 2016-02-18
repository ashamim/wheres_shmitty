//
//  ViewController.swift
//  Wheres Shmitty?
//
//  Created by Ahmed Shamim on 12/23/15.
//  Copyright (c) 2015 Ahmed Shamim. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

class CheckBox: UIButton {
    // Images
    var checkedImage : UIImage? = UIImage(named:"ic_check_box")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    var uncheckedImage : UIImage? = UIImage(named:"ic_check_box_outline_blank")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    
    
    //bool propety
    var isChecked:Bool = false{
        didSet{
            if isChecked == true{
                self.setImage(checkedImage, forState: .Normal)
            }else{
                print("IN here")
                self.setImage(uncheckedImage, forState: .Normal)
            }
        }
    }
    
    func initialize() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender:UIButton) {
        if(sender == self){
            if isChecked == true{
                isChecked = false
            }else{
                isChecked = true
            }
        }
    }
}

var eventsList: [String] = []

class EventLabel: UILabel {
    init (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, val: String, size: CGFloat) {
        super.init(frame: CGRectMake(x, y, width, height))
        self.textColor = UIColor.blackColor()
        self.text = val
        self.font = UIFont(name: "Noteworthy", size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Events: UIViewController {
    
    var scrollView: UIScrollView?
    var eventsLoaded: Int = 0
    var currY: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = initiateScrollView()

        for event in eventsList {
            let label: EventLabel = EventLabel(x: 10, y: currY, width: 200, height: 30, val: event, size: 20)
            let ppl: EventLabel = EventLabel(x: view.frame.width - 160, y: currY, width: 60, height: 21, val: "12/23", size: 20)
            let check: CheckBox = CheckBox(frame: CGRectMake(view.frame.width - 82.5, currY, 20, 21))
            let xbox: CheckBox = CheckBox(frame: CGRectMake(view.frame.width - 47.5, currY, 20, 21))
            check.initialize()
            xbox.initialize()
            scrollView!.addSubview(label)
            scrollView!.addSubview(ppl)
            scrollView!.addSubview(check)
            scrollView!.addSubview(xbox)
        }
        eventsLoaded = eventsList.count
        scrollView!.contentSize = CGSize(width: view.bounds.width, height: currY + 50)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        self.view.addSubview(scrollView!)
        currY += 50
    }
    
    func initiateScrollView() -> UIScrollView {
        let res: UIScrollView = UIScrollView(frame: view.bounds)
        res.backgroundColor = UIColor(hex: 0xffefc9)
        let title: EventLabel = EventLabel(x: 0, y: 20, width: view.frame.width, height: 50, val: "Events", size: 30)
        title.textAlignment = NSTextAlignment.Center
        let att: EventLabel = EventLabel(x: view.frame.width - 150, y: 90, width: 10, height: 12, val: "att.", size: 7)
        let invited: EventLabel = EventLabel(x: view.frame.width - 130, y: 90, width: 20, height: 12, val: "invited", size: 7)
        let going: EventLabel = EventLabel(x: view.frame.width - 80, y: 90, width: 20, height: 12, val: "Going", size: 7)
        let cant: EventLabel = EventLabel(x: view.frame.width - 50, y: 90, width: 25, height: 12, val: "Can't Go", size: 7)
        res.addSubview(title)
        res.addSubview(att)
        res.addSubview(invited)
        res.addSubview(going)
        res.addSubview(cant)
        return res
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

var eventPage: Events?

class CreateEvent: UIViewController {
    
    var txtField: UITextField?
    
    func buttonAction(sender:UIButton!)
    {
        if (txtField!.text != nil) {
            eventsList.append(txtField!.text!)
            if (eventPage != nil) {
                updateEvents()
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }

    }
    
    func updateEvents() {
        let label: EventLabel = EventLabel(x: 10, y: eventPage!.currY, width: 200, height: 30, val: eventsList[eventPage!.eventsLoaded], size: 20)
        let ppl: EventLabel = EventLabel(x: eventPage!.view.frame.width - 160, y: eventPage!.currY, width: 60, height: 21, val: "0/0", size: 20)
        let check: CheckBox = CheckBox(frame: CGRectMake(eventPage!.view.frame.width - 82.5, eventPage!.currY, 20, 21))
        let xbox: CheckBox = CheckBox(frame: CGRectMake(eventPage!.view.frame.width - 47.5, eventPage!.currY, 20, 21))
        check.initialize()
        xbox.initialize()
        eventPage!.currY += 50
        eventPage!.scrollView!.addSubview(label)
        eventPage!.scrollView!.addSubview(ppl)
        eventPage!.scrollView!.addSubview(check)
        eventPage!.scrollView!.addSubview(xbox)
        eventPage!.scrollView!.contentSize = CGSize(width: eventPage!.view.bounds.width, height: eventPage!.currY)
        eventPage!.eventsLoaded += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("BEgINNING VIEW")
        self.view.backgroundColor = UIColor(hex: 0xffefc9)
        txtField = UITextField(frame: CGRect(x: 75, y: 50, width: 200.00, height: 20.00));
        txtField!.borderStyle = UITextBorderStyle.Line
        txtField!.text = "Event Name"
        txtField!.backgroundColor = UIColor.whiteColor()
        let submitBtn: UIButton = UIButton(frame: CGRect(x: 125, y: 100, width: 100, height: 20.00))
        submitBtn.layer.borderColor = UIColor.blackColor().CGColor;
        submitBtn.layer.cornerRadius = 5;
        submitBtn.layer.borderWidth = 1
        submitBtn.setTitle("Submit", forState: UIControlState.Normal)
        submitBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        submitBtn.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(txtField!)
        self.view.addSubview(submitBtn)

    }
    
}

class ViewController: UIViewController {
    
    let socket = SocketIOClient(socketURL: "http://localhost:8900")
    var resetAck: SocketAckEmitter?

    @IBAction func addEvent(sender: AnyObject) {
        let createEvent: CreateEvent = CreateEvent()
        self.presentViewController(createEvent, animated: true, completion: nil)
    }
    
    @IBAction func eventsPage(sender: AnyObject) {
        if (eventPage == nil) {
            eventPage = Events()
        }
        self.presentViewController(eventPage!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHandlers()
        socket.connect()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func addHandlers() {
        socket.on("hello") {data, ack in
            print("Hello world!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

