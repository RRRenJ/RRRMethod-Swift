//
//  PrivacyManager.swift
//  Wishes
//
//  Created by 任敬 on 2019/11/4.
//  Copyright © 2019 任敬. All rights reserved.
//

import UIKit
import Photos
import Contacts
import EventKit
import CoreBluetooth




public enum PrivacyAuthorizationStatus {
    ///未选择权限
    case notDetermined
    ///授权
    case authorized
    ///拒绝
    case denied
    ///应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
    case restricted
    ///不支持
    case notSupport
    ///未知状态
    case unkown
    ///一直允许（定位）
    case authorizedAlways
    ///使用时(定位)
    case authorizedWhenInUse
}

public enum PrivacyCBManagerStatus {
    ///未知状态
    case unkown
    ///正在重置，与系统服务暂时丢失
    case resetting
    ///不支持蓝牙
    case unsupport
    ///未授权
    case unauthorized
    ///关闭
    case poweredOff
    ///开启并可用
    case poweredOn
}

public enum PrivacyUsage {
    case camera
    case photo
    case microphone
    case contacts
    case loactionAlways
    case loactionWhenInUse
    case calendar
}

public enum PrivacyPath {
    case privacy
    case bluetooth
}


public class PrivacyManager: NSObject {

    public static let `default` = PrivacyManager()

    private typealias CBManagerStatusBlock = (CBCentralManagerState) -> Void

    private var cbStatusBlock : CBManagerStatusBlock?
    
    private typealias LocationStatusBlock = (CLAuthorizationStatus) -> Void

    private var lcStatusBlock : LocationStatusBlock?

    private override init() {
        super.init()
 
    }
    
    static func canUsage( privacy : PrivacyUsage) -> PrivacyAuthorizationStatus {
        switch privacy {
            case .camera:
                return self.checkCamera()
            case .photo:
               return self.checkPhoto()
            case .microphone:
               return self.checkMicrophone()
            case .contacts:
               return self.checkContacts()
            case .loactionAlways, .loactionWhenInUse:
               return self.checkLocation()
            case .calendar:
               return self.checkCalendars()
        }
    }

//    private lazy var cManager: CBCentralManager = {
//        var manager = CBCentralManager.init(delegate: self, queue: nil)
//        return manager
//    }()
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
       
        return manager
    }()
    
    
}
///checkPrivacy
private extension PrivacyManager {
    static func checkCamera() -> PrivacyAuthorizationStatus  {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let status = AVCaptureDevice.authorizationStatus(for: .video)
                switch status {
                case .notDetermined:
                    return .notDetermined
                case .restricted:
                    return .restricted
                case .denied:
                    return .denied
                case .authorized:
                    return .authorized
                @unknown default:
                    return .unkown
                }
            }else{
                return .notSupport
            }
        }
    
    static func checkPhoto() -> PrivacyAuthorizationStatus  {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let status = PHPhotoLibrary.authorizationStatus()
                switch status {
                case .notDetermined:
                    return .notDetermined
                case .restricted:
                    return .restricted
                case .denied:
                    return .denied
                case .authorized:
                    return .authorized
                @unknown default:
                    return .unkown
                }
            }else{
                return .notSupport
            }
        }
    static func checkMicrophone() -> PrivacyAuthorizationStatus  {
            let status = AVCaptureDevice.authorizationStatus(for: .audio)
            switch status {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            case .denied:
                return .denied
            case .authorized:
                return .authorized
            @unknown default:
                return .unkown
            }
        }
        
    static func checkContacts() -> PrivacyAuthorizationStatus  {
            let status = CNContactStore.authorizationStatus(for: .contacts)
            switch status {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            case .denied:
                return .denied
            case .authorized:
                return .authorized
            @unknown default:
                return .unkown
            }
        }
        
    static func checkCalendars() -> PrivacyAuthorizationStatus  {
            let status = EKEventStore.authorizationStatus(for: .event)
            switch status {
            case .notDetermined:
                return .notDetermined
            case .restricted:
                return .restricted
            case .denied:
                return .denied
            case .authorized:
                return .authorized
            @unknown default:
                return .unkown
            }
        }
        
    static func checkLocation() -> PrivacyAuthorizationStatus  {
            if CLLocationManager.locationServicesEnabled() {
                let status = CLLocationManager.authorizationStatus()
                switch status {
                case .notDetermined:
                    return .notDetermined
                case .restricted:
                    return .restricted
                case .denied:
                    return .denied
                case .authorizedAlways:
                    return .authorizedAlways
                case .authorizedWhenInUse:
                    return .authorizedWhenInUse
                @unknown default:
                    return .unkown
                }
            }else{
                return .notSupport
            }
        }
}
///checkBluetooth
// extension PrivacyManager : CBCentralManagerDelegate {
//
//   public func canUsageBluetooth(completetion : @escaping (PrivacyCBManagerStatus) -> Void ) {
//        self.cManager.delegate = self
//        self.cbStatusBlock = { status in
//            switch status {
//            case .resetting:
//                completetion(.resetting)
//            case .unsupported:
//                completetion(.unsupport)
//            case .unauthorized:
//                completetion(.unauthorized)
//            case .poweredOff:
//                completetion(.poweredOff)
//            case .poweredOn:
//                completetion(.poweredOn)
//            default:
//                completetion(.unkown)
//            }
//        }
//    }
//
//
//    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        var state = CBCentralManagerState.unknown
//        switch central.state {
//        case .unknown:
//            state = .unknown
//        case .resetting:
//            state = .resetting
//        case .unsupported:
//            state = .unsupported
//        case .unauthorized:
//            state = .unauthorized
//        case .poweredOff:
//            state = .poweredOff
//        case .poweredOn:
//            state = .poweredOn
//        @unknown default:
//            state = .unknown
//        }
//        if let _ = self.cbStatusBlock{
//            self.cbStatusBlock!(state)
//        }
//     }
//
//}
///registerPrivacy
public extension PrivacyManager {
    
    func registerLocation(type : PrivacyUsage , completetion : @escaping (PrivacyAuthorizationStatus) -> Void) {
        let locationStatus = PrivacyManager.checkLocation()
        switch locationStatus {
        case .notDetermined:
            if type == .loactionAlways {
                self.locationManager.requestAlwaysAuthorization()
            }else if type == .loactionWhenInUse{
                self.locationManager.requestWhenInUseAuthorization()
            }else{
                completetion(.unkown)
                break
            }
            self.lcStatusBlock = { status in
                
                DispatchQueue.main.async {
                    switch status {
                    case .notDetermined:
                        completetion(.notDetermined)
                    case .restricted:
                        completetion(.restricted)
                    case .denied:
                        completetion(.denied)
                    case .authorizedAlways:
                        completetion(.authorizedAlways)
                    case .authorizedWhenInUse:
                        completetion(.authorizedWhenInUse)
                    @unknown default:
                        completetion(.unkown)
                    }
                }
            }
        default:
             completetion(locationStatus)
        }
    }
    
    func registerPrivacy(type : PrivacyUsage , completetion : @escaping (PrivacyAuthorizationStatus) -> Void) {
        switch type {
        case .camera:
            let status =  PrivacyManager.checkCamera()
            if status == .notDetermined{
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        if granted {
                            completetion(.authorized)
                        }else{
                            completetion(.denied)
                        }
                    }

                }
            }else{
                completetion(status)
            }
        case .photo:
            let status =  PrivacyManager.checkPhoto()
            if status == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                   DispatchQueue.main.async {
                        switch status {
                        case .notDetermined:
                            return completetion(.notDetermined)
                        case .restricted:
                            return completetion(.restricted)
                        case .denied:
                            return completetion(.denied)
                        case .authorized:
                            return completetion(.authorized)
                        @unknown default:
                            return completetion(.unkown)
                        }
                    }
                }
            }else{
                return completetion(status)
            }
        case .calendar:
            let status =  PrivacyManager.checkCalendars()
            if status == .notDetermined {
                EKEventStore().requestAccess(to: .event) { (granted, error) in
                    DispatchQueue.main.async {
                        if let _ = error {
                            return completetion(.denied)
                        }else {
                            if granted {
                                return completetion(.authorized)
                            }else{
                                return completetion(.denied)
                            }
                        }
                    }
                }
            }else{
                return completetion(status)
            }
        case .contacts:
            let status =  PrivacyManager.checkContacts()
            if status == .notDetermined {
                CNContactStore().requestAccess(for: .contacts) { (granted, error) in
                    DispatchQueue.main.async {
                        if let _ = error {
                            return completetion(.denied)
                        }else {
                            if granted {
                                return completetion(.authorized)
                            }else{
                                return completetion(.denied)
                            }
                        }
                    }
                }
            }else{
                return completetion(status)
            }
        case .microphone:
            let status =  PrivacyManager.checkMicrophone()
            if status == .notDetermined{
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    DispatchQueue.main.async {
                        if granted {
                            completetion(.authorized)
                        }else{
                            completetion(.denied)
                        }
                    }
                }
            }else{
                completetion(status)
            }
        default:
            break
        }
    }
}

extension PrivacyManager : CLLocationManagerDelegate {
   public  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if let _ = self.lcStatusBlock{
            self.lcStatusBlock!(status)
        }
    }
}

public extension PrivacyManager {
    static func jumpToPrivacy(path : PrivacyPath){
        var url : URL?
        if path == .privacy {
            url = URL(string: "prefs:root=privacy")
            if let purl = url , UIApplication.shared.canOpenURL(purl){
                UIApplication.shared.openURL(purl)
            }
        }else{
            url = URL(string: "prefs:root=Bluetooth")
            if let purl = url , UIApplication.shared.canOpenURL(purl){
                UIApplication.shared.openURL(purl)
            }
        }
    }
}

