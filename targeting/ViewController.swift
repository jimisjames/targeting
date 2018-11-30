//
//  ViewController.swift
//  targeting
//
//  Created by Jim Lambert on 11/19/18.
//  Copyright © 2018 Jim Lambert. All rights reserved.
//

import UIKit
import ARKit
import CoreLocation
import SceneKit
import CoreMotion

class ViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, ARSCNViewDelegate {
    
    let motionManager = CMMotionManager()
    var myRollInRadians = 0.0
    
    func setUpMotion(){
        motionManager.deviceMotionUpdateInterval = 0.05
        motionManager.startDeviceMotionUpdates(to: .main , withHandler: { (deviceMotion, error) in
            self.myRollInRadians = (deviceMotion?.attitude.roll)!
            //print("roll in radians: \( (deviceMotion?.attitude.roll)!)")
            //print("roll in degrees: \( GLKMathRadiansToDegrees(Float((deviceMotion?.attitude.roll)!)))")
        })
    }
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.startUpdatingHeading()
        $0.startUpdatingLocation()
        return $0
    }(CLLocationManager())
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            NSLog("error no last location")
            return
        }
        let alt = lastLocation.altitude
        actualElevationLabel.text = "\(Int(alt * 3.2808399))' MSL"
        
    }
    
    //global targeting variables
    var bearing: Float?
    var distanceAway: Float?
    var myHeadingInRadians: Float?
    
    //main hub labels
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mySceneView: ARSCNView!
    @IBOutlet weak var rightRedArrow: UIImageView!
    @IBOutlet weak var leftRedArrow: UIImageView!
    @IBOutlet weak var targetInfoLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var weaponLabel: UILabel!
    
    //enter target buttons
    @IBOutlet weak var directionDistanceInputLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var meterLabel: UILabel!
    @IBOutlet weak var gridInputLabel: UILabel!
    @IBOutlet weak var latLonInputLabel: UILabel!
    @IBOutlet weak var elevationLabel: UILabel!
    @IBOutlet weak var actualElevationLabel: UILabel!
    @IBOutlet weak var targetEnterButton: UIButton!
    @IBOutlet weak var degreeSymbolLabel: UILabel!
    
    //enter target inputs
    @IBOutlet weak var directionInput: UITextField!
    @IBOutlet weak var distanceInput: UITextField!
    @IBOutlet weak var latInput: UITextField!
    @IBOutlet weak var longInput: UITextField!
    
    // main buttons
    @IBOutlet weak var enterTargetButton: UIButton!
    @IBOutlet weak var selectWeaponButton: UIButton!
    @IBOutlet weak var setTimeButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var runDemoBtn: UIButton!
    
    // select weapon buttons
    @IBOutlet weak var strafe20mmBtn: UIButton!
    @IBOutlet weak var strafe30mmBtn: UIButton!
    @IBOutlet weak var unguidedBombBtn: UIButton!
    @IBOutlet weak var laserGuidedBtn: UIButton!
    @IBOutlet weak var inertiallyAidedBtn: UIButton!
    @IBOutlet weak var weaponEnterBtn: UIButton!
    
    // set time buttons
    @IBOutlet weak var timeOnBtn: UIButton!
    @IBOutlet weak var timeToBtn: UIButton!
    @IBOutlet weak var tenSecondsBtn: UIButton!
    @IBOutlet weak var thirtySecondsBtn: UIButton!
    @IBOutlet weak var setTimeEnter: UIButton!
    
    
    @IBAction func menuBtnPressed(_ sender: Any) {
        if enterTargetButton.isHidden == true {
            //print("****************")
            menuButton.setTitle("Back", for: .normal)
            enterTargetButton.isHidden = false
            selectWeaponButton.isHidden = false
            setTimeButton.isHidden = false
            if setTimeButton.layer.borderColor == UIColor.green.cgColor && enterTargetButton.layer.borderColor == UIColor.green.cgColor && selectWeaponButton.layer.borderColor == UIColor.green.cgColor {
                runDemoBtn.isHidden = false
            }
        } else {
            //print("######################")
            menuButton.setTitle("Menu", for: .normal)
            enterTargetButton.isHidden = true
            selectWeaponButton.isHidden = true
            setTimeButton.isHidden = true
            actualElevationLabel.isHidden = true
            directionDistanceInputLabel.isHidden = true
            gridInputLabel.isHidden = true
            latLonInputLabel.isHidden = true
            elevationLabel.isHidden = true
            targetEnterButton.isHidden = true
            degreeLabel.isHidden = true
            directionInput.isHidden = true
            distanceInput.isHidden = true
            meterLabel.isHidden = true
            strafe20mmBtn.isHidden = true
            strafe30mmBtn.isHidden = true
            unguidedBombBtn.isHidden = true
            laserGuidedBtn.isHidden = true
            inertiallyAidedBtn.isHidden = true
            weaponEnterBtn.isHidden = true
            timeOnBtn.isHidden = true
            timeToBtn.isHidden = true
            tenSecondsBtn.isHidden = true
            thirtySecondsBtn.isHidden = true
            setTimeEnter.isHidden = true
            runDemoBtn.isHidden = true
            degreeSymbolLabel.isHidden = true
            latInput.isHidden = true
            longInput.isHidden = true
        }
    }
    
    @IBAction func enterTargetBtnPressed(_ sender: UIButton) {
        if directionDistanceInputLabel.isHidden == true {
            actualElevationLabel.isHidden = false
            directionDistanceInputLabel.isHidden = false
            gridInputLabel.isHidden = false
            latLonInputLabel.isHidden = false
            elevationLabel.isHidden = false
            targetEnterButton.isHidden = false
            degreeLabel.isHidden = false
            directionInput.isHidden = false
            distanceInput.isHidden = false
            meterLabel.isHidden = false
            //degreeSymbolLabel.isHidden = false
            //latInput.isHidden = false∫
            //longInput.isHidden = false
            // hide other buttons
            strafe20mmBtn.isHidden = true
            strafe30mmBtn.isHidden = true
            unguidedBombBtn.isHidden = true
            laserGuidedBtn.isHidden = true
            inertiallyAidedBtn.isHidden = true
            weaponEnterBtn.isHidden = true
            timeOnBtn.isHidden = true
            timeToBtn.isHidden = true
            tenSecondsBtn.isHidden = true
            thirtySecondsBtn.isHidden = true
            setTimeEnter.isHidden = true
        } else {
            //addScene(-5.0)
            actualElevationLabel.isHidden = true
            directionDistanceInputLabel.isHidden = true
            gridInputLabel.isHidden = true
            latLonInputLabel.isHidden = true
            elevationLabel.isHidden = true
            targetEnterButton.isHidden = true
            degreeLabel.isHidden = true
            directionInput.isHidden = true
            distanceInput.isHidden = true
            meterLabel.isHidden = true
            degreeSymbolLabel.isHidden = true
            latInput.isHidden = true
            longInput.isHidden = true
        }
    }
    
    @IBAction func targetEnterBtnPressed(_ sender: UIButton) {
        //print("Current lat: \(locationManager.location?.coordinate.latitude)")
        //print("Current long: \(locationManager.location?.coordinate.longitude)")

        if let degrees = Float(directionInput.text!) {
            self.bearing = GLKMathDegreesToRadians(degrees)
        }
        if let distance = Float(distanceInput.text!) {
            distanceAway = distance
        }
//        } else {
//            let myLatRads = GLKMathDegreesToRadians(Float(locationManager.location!.coordinate.latitude))
////            let myLongRads = GLKMathDegreesToRadians(Float(locationManager.location!.coordinate.longitude))
//
//            if let nodeLat = Float(latInput.text!) {
//                let nodeLatRads = GLKMathDegreesToRadians(nodeLat)
//                if Float(longInput.text!) != nil {
//                    print(Float(longInput.text!))
////                    let nodeLongRads = GLKMathDegreesToRadians(nodeLong)
//                    let x = Float(locationManager.location!.coordinate.longitude) - Float(longInput.text!)!
//                    var dist = sin(myLatRads) * sin(nodeLatRads) + cos(myLatRads) * cos(nodeLatRads) * cos(GLKMathDegreesToRadians(x))
//                    print(dist)
//                    dist = acos(dist)
//                    dist = GLKMathRadiansToDegrees(dist)
//                    dist = dist * 60 * 1.1515
//                    dist = dist * 1.609344 * 1000
//                    distanceAway = dist
//                    print("distance away: \(distanceAway)")
//                }
//            }
        if bearing != nil && distanceAway != nil {
            targetInfoLabel.text = "TARGET: DIRECTION: \(Int(GLKMathRadiansToDegrees(bearing!)))° DISTANCE: \(Int(distanceAway!))m ELEVATION: \(Int((locationManager.location?.altitude)! * 3.2808399))'"
            targetInfoLabel.isHidden = false
            enterTargetButton.layer.borderWidth = 2
            enterTargetButton.layer.borderColor = UIColor.green.cgColor
            
            actualElevationLabel.isHidden = true
            directionDistanceInputLabel.isHidden = true
            gridInputLabel.isHidden = true
            latLonInputLabel.isHidden = true
            elevationLabel.isHidden = true
            targetEnterButton.isHidden = true
            degreeLabel.isHidden = true
            directionInput.isHidden = true
            directionInput.text = ""
            distanceInput.isHidden = true
            distanceInput.text = ""
            meterLabel.isHidden = true
            degreeSymbolLabel.isHidden = true
            latInput.isHidden = true
            latInput.text = ""
            longInput.isHidden = true
            longInput.text = ""
            if setTimeButton.layer.borderColor == UIColor.green.cgColor && selectWeaponButton.layer.borderColor == UIColor.green.cgColor {
                runDemoBtn.isHidden = false
            }
        }
        
//        let R: Float = 6378.1
//        let distanceAway = Float(distanceInput.text!)! / 1000.0
//        let x = GLKMathDegreesToRadians(Float((locationManager.location?.coordinate.latitude)!))
//        let y = GLKMathDegreesToRadians(Float((locationManager.location?.coordinate.longitude)!))
//        let newLat = asin(sin(x) * cos(distanceAway / R) + cos(x) * sin(distanceAway / R) * cos(bearing))
//        let newLong = y + atan2(sin(bearing) * sin(distanceAway / R) * cos(x), cos(distanceAway / R) - sin(x) * sin(newLat))
//        print(GLKMathRadiansToDegrees(newLat))
//        print(GLKMathRadiansToDegrees(newLong))
        
        //addScene(angleClockwiseFromNorthInRadians: bearing, distanceInMeters: Float(distanceInput.text!) ?? 1.0)
    }
    @IBAction func selectWeaponBtnPressed(_ sender: UIButton) {
        if strafe20mmBtn.isHidden == true {
            strafe20mmBtn.isHidden = false
            strafe30mmBtn.isHidden = false
            unguidedBombBtn.isHidden = false
            laserGuidedBtn.isHidden = false
            inertiallyAidedBtn.isHidden = false
            weaponEnterBtn.isHidden = false
            // hide other buttons
            timeOnBtn.isHidden = true
            timeToBtn.isHidden = true
            tenSecondsBtn.isHidden = true
            thirtySecondsBtn.isHidden = true
            setTimeEnter.isHidden = true
            actualElevationLabel.isHidden = true
            directionDistanceInputLabel.isHidden = true
            gridInputLabel.isHidden = true
            latLonInputLabel.isHidden = true
            elevationLabel.isHidden = true
            targetEnterButton.isHidden = true
            degreeLabel.isHidden = true
            directionInput.isHidden = true
            distanceInput.isHidden = true
            meterLabel.isHidden = true
            degreeSymbolLabel.isHidden = true
            latInput.isHidden = true
            longInput.isHidden = true
        } else {
            strafe20mmBtn.isHidden = true
            strafe30mmBtn.isHidden = true
            unguidedBombBtn.isHidden = true
            laserGuidedBtn.isHidden = true
            inertiallyAidedBtn.isHidden = true
            weaponEnterBtn.isHidden = true
        }
    }
    
    @IBAction func unguidedPressed(_ sender: UIButton) {
        unguidedBombBtn.layer.borderWidth = 2
        unguidedBombBtn.layer.borderColor = UIColor.darkGray.cgColor
        unguidedBombBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        weaponChoice = 3
    }
    
    var weaponChoice = 0
    
    @IBAction func weaponEnterBtnPressed(_ sender: UIButton) {
        if unguidedBombBtn.layer.borderColor == UIColor.darkGray.cgColor || weaponChoice != 0 {
            selectWeaponButton.layer.borderWidth = 2
            selectWeaponButton.layer.borderColor = UIColor.green.cgColor
            
            strafe20mmBtn.isHidden = true
            strafe30mmBtn.isHidden = true
            unguidedBombBtn.isHidden = true
            laserGuidedBtn.isHidden = true
            inertiallyAidedBtn.isHidden = true
            weaponEnterBtn.isHidden = true
            if setTimeButton.layer.borderColor == UIColor.green.cgColor && enterTargetButton.layer.borderColor == UIColor.green.cgColor {
                runDemoBtn.isHidden = false
            }
        }
    }
    
    @IBAction func setTimeBtnPressed(_ sender: UIButton) {
        if timeOnBtn.isHidden == true {
            timeOnBtn.isHidden = false
            timeToBtn.isHidden = false
            tenSecondsBtn.isHidden = false
            thirtySecondsBtn.isHidden = false
            setTimeEnter.isHidden = false
            // hide other buttons
            strafe20mmBtn.isHidden = true
            strafe30mmBtn.isHidden = true
            unguidedBombBtn.isHidden = true
            laserGuidedBtn.isHidden = true
            inertiallyAidedBtn.isHidden = true
            weaponEnterBtn.isHidden = true
            actualElevationLabel.isHidden = true
            directionDistanceInputLabel.isHidden = true
            gridInputLabel.isHidden = true
            latLonInputLabel.isHidden = true
            elevationLabel.isHidden = true
            targetEnterButton.isHidden = true
            degreeLabel.isHidden = true
            directionInput.isHidden = true
            distanceInput.isHidden = true
            meterLabel.isHidden = true
            degreeSymbolLabel.isHidden = true
            latInput.isHidden = true
            longInput.isHidden = true
        } else {
            timeOnBtn.isHidden = true
            timeToBtn.isHidden = true
            tenSecondsBtn.isHidden = true
            thirtySecondsBtn.isHidden = true
            setTimeEnter.isHidden = true
        }
    }
    
    @IBAction func tenSecondsPressed(_ sender: UIButton) {
        tenSecondsBtn.layer.borderWidth = 2
        tenSecondsBtn.layer.borderColor = UIColor.darkGray.cgColor
        tenSecondsBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        timeDelay = 10.0
        
        // reset 30 btn
        thirtySecondsBtn.layer.borderWidth = 0
        thirtySecondsBtn.layer.borderColor = UIColor.white.cgColor
        thirtySecondsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
    }
    
    @IBAction func thirtySecondsBtnPressed(_ sender: UIButton) {
        thirtySecondsBtn.layer.borderWidth = 2
        thirtySecondsBtn.layer.borderColor = UIColor.darkGray.cgColor
        thirtySecondsBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        timeDelay = 30.0
        
        // reset 10 btn
        tenSecondsBtn.layer.borderWidth = 0
        tenSecondsBtn.layer.borderColor = UIColor.white.cgColor
        tenSecondsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
    }
    
    @IBAction func setTimeEnterPressed(_ sender: UIButton) {
        if tenSecondsBtn.layer.borderColor == UIColor.darkGray.cgColor || thirtySecondsBtn.layer.borderColor == UIColor.darkGray.cgColor {
            setTimeButton.layer.borderWidth = 2
            setTimeButton.layer.borderColor = UIColor.green.cgColor
            
            timeOnBtn.isHidden = true
            timeToBtn.isHidden = true
            tenSecondsBtn.isHidden = true
            thirtySecondsBtn.isHidden = true
            setTimeEnter.isHidden = true
            
            runDemoBtn.layer.borderWidth = 1
            runDemoBtn.layer.borderColor = UIColor.red.cgColor
            runDemoBtn.layer.cornerRadius = 10
            if enterTargetButton.layer.borderColor == UIColor.green.cgColor && selectWeaponButton.layer.borderColor == UIColor.green.cgColor {
                runDemoBtn.isHidden = false
            }
        }
    }
    
    @IBAction func runDemoBtnPressed(_ sender: UIButton) {
        addScene(angleClockwiseFromNorthInRadians: bearing ?? 0.0, distanceInMeters: distanceAway ?? 0.0)
        weaponLabel.isHidden = false
        timerLabel.text = "TTT: \(Int(timeDelay)) sec"
        timerLabel.isHidden = false
        countDown()
        
        // hide everything
        
        menuButton.setTitle("Menu", for: .normal)
        enterTargetButton.isHidden = true
        selectWeaponButton.isHidden = true
        setTimeButton.isHidden = true
        actualElevationLabel.isHidden = true
        directionDistanceInputLabel.isHidden = true
        gridInputLabel.isHidden = true
        latLonInputLabel.isHidden = true
        elevationLabel.isHidden = true
        targetEnterButton.isHidden = true
        degreeLabel.isHidden = true
        directionInput.isHidden = true
        distanceInput.isHidden = true
        meterLabel.isHidden = true
        strafe20mmBtn.isHidden = true
        strafe30mmBtn.isHidden = true
        unguidedBombBtn.isHidden = true
        laserGuidedBtn.isHidden = true
        inertiallyAidedBtn.isHidden = true
        weaponEnterBtn.isHidden = true
        timeOnBtn.isHidden = true
        timeToBtn.isHidden = true
        tenSecondsBtn.isHidden = true
        thirtySecondsBtn.isHidden = true
        setTimeEnter.isHidden = true
        runDemoBtn.isHidden = true
        degreeSymbolLabel.isHidden = true
        latInput.isHidden = true
        longInput.isHidden = true
        
        // reset everything
        enterTargetButton.layer.borderColor = UIColor.red.cgColor
        enterTargetButton.layer.borderWidth = 1
        selectWeaponButton.layer.borderColor = UIColor.red.cgColor
        selectWeaponButton.layer.borderWidth = 1
        setTimeButton.layer.borderColor = UIColor.red.cgColor
        setTimeButton.layer.borderWidth = 1
        tenSecondsBtn.layer.borderColor = UIColor.white.cgColor
        tenSecondsBtn.layer.borderWidth = 0
        tenSecondsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        unguidedBombBtn.layer.borderColor = UIColor.white.cgColor
        unguidedBombBtn.layer.borderWidth = 0
        unguidedBombBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMotion()
        //addScene(angleClockwiseFromNorthInRadians: 1.0, distanceInMeters: 3.0)
        directionInput.delegate = self
        distanceInput.delegate = self
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //style button borders
        menuButton.layer.cornerRadius = 15
        enterTargetButton.layer.borderColor = UIColor.red.cgColor
        enterTargetButton.layer.borderWidth = 1
        selectWeaponButton.layer.borderColor = UIColor.red.cgColor
        selectWeaponButton.layer.borderWidth = 1
        setTimeButton.layer.borderColor = UIColor.red.cgColor
        setTimeButton.layer.borderWidth = 1

        directionInput.isHidden = true
        distanceInput.isHidden = true
        enterTargetButton.isHidden = true
        selectWeaponButton.isHidden = true
        setTimeButton.isHidden = true
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        mySceneView.delegate = self
        mySceneView.session.run(configuration)
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            
            self.timeLabel.text = "\(dateFormatter.string(from: Date()))"
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mySceneView.session.pause()
    }
    
    var times = 1
    var sceneNode: SCNNode?
    var targetingTimer = Timer()
    var timeDelay = 1.0
    
    func addScene(angleClockwiseFromNorthInRadians: Float, distanceInMeters: Float) {

        let plane = SCNPlane(width: 50, height: 50)
        let planeNode = SCNNode()
        planeNode.geometry = plane
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "crosshair")
        sceneNode = planeNode
        
        let _ = Timer.scheduledTimer(withTimeInterval: timeDelay, repeats: false) { timer in
            self.explode()
        }
        let distance: Float

        if distanceInMeters > 1000.0 {
            distance = 1000.0
        } else {
            distance = distanceInMeters
        }
        let x = distance * sin(angleClockwiseFromNorthInRadians)
        let z = distance * -1 * cos(angleClockwiseFromNorthInRadians)
    
        planeNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: (angleClockwiseFromNorthInRadians * -1))
        planeNode.position = SCNVector3(x, 0, z)
        let scene = SCNScene()
        scene.rootNode.addChildNode(planeNode)
        
//        let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0)
//        let x = distanceInMeters * sin(angleClockwiseFromNorthInRadians)
//        let z = distanceInMeters * -1 * cos(angleClockwiseFromNorthInRadians)
//        let boxNode = SCNNode()
//        boxNode.geometry = box
//        boxNode.position = SCNVector3(x, 0, z)
//        let scene = SCNScene()
//        scene.rootNode.addChildNode(boxNode)

        mySceneView.scene = scene
        locateTarget()
    }
    
    func locateTarget(){
        targetingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if let pointOfView = self.mySceneView.pointOfView {
                let vis = self.mySceneView.isNode(self.sceneNode!, insideFrustumOf: pointOfView)
                
                if vis == false {
                    
                    // Arrow Rotation & Height
                    
                    if self.myRollInRadians < -1.92 {
                        self.leftRedArrow.transform = CGAffineTransform(translationX: -10, y: 135)
                        self.leftRedArrow.transform = self.leftRedArrow.transform.rotated(by: -0.7853)
                        self.rightRedArrow.transform = CGAffineTransform(translationX: 10, y: 135)
                        self.rightRedArrow.transform = self.rightRedArrow.transform.rotated(by: 0.7853)
                    } else if self.myRollInRadians > -1.22 {
                        self.leftRedArrow.transform = CGAffineTransform(translationX: -10, y: -110)
                        self.leftRedArrow.transform = self.leftRedArrow.transform.rotated(by: 0.7853)
                        self.rightRedArrow.transform = CGAffineTransform(translationX: 10, y: -110)
                        self.rightRedArrow.transform = self.rightRedArrow.transform.rotated(by: -0.7853)
                    } else {
                        self.leftRedArrow.transform = CGAffineTransform(rotationAngle: 0.0)
                        self.rightRedArrow.transform = CGAffineTransform(rotationAngle: 0.0)
                    }
                    
                    
                    // Which Arrow is showing
                    if let nodeBearing = self.bearing {
                        let myBearing = self.myHeadingInRadians!
//                        var halfway: Float
//                        if nodeBearing < 3.14159 {
//                            halfway = nodeBearing + 3.14159
//                        } else {
//                            halfway = nodeBearing - 3.14159
//                        }
//                        print("myBearing: \(myBearing)")
//                        print("halfway: \(halfway)")
//                        print("nodeBearing: \(nodeBearing)")
                        
                        if myBearing > nodeBearing {
                            if myBearing - nodeBearing > 3.14159 {
                                self.leftRedArrow.isHidden = true
                                self.rightRedArrow.isHidden = false
                            } else {
                                self.leftRedArrow.isHidden = false
                                self.rightRedArrow.isHidden = true
                            }
                        } else {
                            if myBearing + 6.183 - nodeBearing > 3.14159 {
                                self.leftRedArrow.isHidden = true
                                self.rightRedArrow.isHidden = false
                            } else {
                                self.leftRedArrow.isHidden = false
                                self.rightRedArrow.isHidden = true
                            }
                        }
                    }
                } else {
                    self.leftRedArrow.isHidden = true
                    self.rightRedArrow.isHidden = true
                }
            }
        }
    }
    
    func explode(){
        let _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { timer in
            
            self.sceneNode!.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "explosion\(self.times)")
            self.times += 1
            if self.times <= 14 {
                self.explode()
            } else {
                self.targetingTimer.invalidate()
                self.leftRedArrow.isHidden = true
                self.rightRedArrow.isHidden = true
                self.times = 1
                self.weaponLabel.isHidden = true
                self.timerLabel.isHidden = true
                self.targetInfoLabel.isHidden = true
            }
        }
    }
    
    func countDown(){
        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            if self.timeDelay > 1 {
                self.timeDelay -= 1
                self.timerLabel.text = "TTT: \(Int(self.timeDelay)) sec"
                self.countDown()
            } else {
                let main_string = "TTT: -- sec"
                let string_to_color = "--"
                
                let range = (main_string as NSString).range(of: string_to_color)
                let attributedString = NSMutableAttributedString(string:main_string)
                attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
                self.timerLabel.attributedText = attributedString
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        UIView.animate(withDuration: 0.5) {
            if newHeading.trueHeading > 270.0 {
                self.myHeadingInRadians = GLKMathDegreesToRadians(Float(newHeading.trueHeading - 270))
                self.directionLabel.text = "\(Int(newHeading.trueHeading - 270))°"
            } else {
                self.myHeadingInRadians = GLKMathDegreesToRadians(Float(90 + newHeading.trueHeading))
                self.directionLabel.text = "\(Int(90 + newHeading.trueHeading))°"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

