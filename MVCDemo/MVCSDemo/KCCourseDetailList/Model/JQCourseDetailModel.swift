//
//  JQCourseDetailModel.swift
//  MVCDemo
//
//  Created by 李佳琪 on 2017/11/16.
//  Copyright © 2017年 lijiaqi. All rights reserved.
//

import UIKit

class JQCourseDetailModel: JQTableModel {
    
    let detailservice = JQNetworkService()
    let replayService = JQNetworkService()
    
    open func loadCourseDetail(_ parameters : [String:Any]? = nil,
                        completion : @escaping ([String:Any]?)->Void ,
                        failure : @escaping (Error)->Void){
        
        let urlStr1 = "https://mobileviptest.kaochong.com/api/mycourse/detail?ca=%E6%9C%AA%E7%9F%A5%E8%BF%90%E8%90%A5%E5%95%86&ov=11.1&rosType=ios&apiVer=2&courseId=745&cl=appstore&sh=1334&ver=1.0.0&dv=iPhoneSimulator&token=6809351333EF8E46AA833E81F48FFCD6C2D0EDC25C0BD2D4E7021031532BE4AD&odv=x86_64&sw=750&classId=793&nt=wifi&duid=4C2AE32806603A5909984053620897806E8B4429F13CA9EF3D9E23A8E99740DC256DFE8FDEC58316BFAFF740F00DEF27"
        
        detailservice.request(parameters: nil, urlStr: urlStr1, completionHandler: { [weak self](response:JQNetResponse<JQCourseDetailVo>) in
            var dic = [String:Any]()
            if let courseDetail = response.results{
                dic["courseDetail"] = courseDetail
            }
            
            completion(dic)
        }) { (error) in
            failure(error)
        }
    }
    
    open func loadReplayDetail(_ parameters : [String:Any]? = nil,
                               completion : @escaping ([String:Any]?)->Void ,
                               failure : @escaping (Error)->Void){
        
        let urlStr1 = "https://mobileviptest.kaochong.com/api/mycourse/listPlaybackLesson?ca=%E6%9C%AA%E7%9F%A5%E8%BF%90%E8%90%A5%E5%95%86&ov=11.1&rosType=ios&apiVer=2&courseId=745&cl=appstore&sh=1334&ver=1.0.0&dv=iPhoneSimulator&token=6809351333EF8E46AA833E81F48FFCD6C2D0EDC25C0BD2D4E7021031532BE4AD&odv=x86_64&sw=750&classId=793&nt=wifi&duid=4C2AE32806603A5909984053620897806E8B4429F13CA9EF3D9E23A8E99740DC256DFE8FDEC58316BFAFF740F00DEF27"
        
        replayService.request(parameters: nil, urlStr: urlStr1, completionHandler: {[weak self](response:JQNetResponse<JQCourseLessonsVo>) in
            self?.wrapperItems(response: response.results)
            completion(nil)
        }) { (error) in
            failure(error)
        }
    }
    
    open func wrapperItems(response:JQCourseLessonsVo?){
        
        if let group = response?.list{
            
            var cellItems: [JQTableListItem] = []
            for groupVo in group{
                let groupItem = JQCourseDetailGroupItem.init(with: groupVo)
                
                cellItems.append(groupItem)
                for lessonItem in groupItem.lessonItems{
                    cellItems.append(lessonItem)
                }
            }
            
            let sectionHeaderItem = JQCourseDetailSectionItem(withType: .header)
            sectionHeaderItem.title = "回放课表"
            sectionHeaderItem.height = 62
            
            var sectionItem = JQSectionItem()
            sectionItem.headerItem = sectionHeaderItem
            sectionItem.items = cellItems
            
            self.sectionItems.append(sectionItem)
        }
    }
    
    func resetItems(){
        var cellItems: [JQTableListItem] = []
        
        var sectionItem = self.sectionItems[0]
        
        for item in sectionItem.items{
            if let groupItem = item as?JQCourseDetailGroupItem{
                cellItems.append(groupItem)
                if !groupItem.isclose{
                    for lessonItem in groupItem.lessonItems{
                        cellItems.append(lessonItem)
                    }
                }
            }
        }
    sectionItem.items = cellItems
    self.sectionItems = [sectionItem]
    }
    
//    func wrapperItems(response:JQCourseLessonsVo?){
//
//        if let group = response?.list{
//
//            var cellItems: [JQTableListItem] = []
//            for groupVo in group{
//                let groupItem = JQCourseDetailGroupItem.init(with: groupVo)
//
//                cellItems.append(groupItem)
//                for lessonItem in groupItem.lessonItems{
//                    cellItems.append(lessonItem)
//                }
//            }
//
//            let sectionHeaderItem = JQCourseDetailSectionItem(withType: .header)
//            sectionHeaderItem.title = "回放课表"
//            sectionHeaderItem.height = 62
//
//            var section = JQSectionItem()
//            section.headerItem = sectionHeaderItem
//            section.items = cellItems
//
//            self.sectionItems.append(section)
//        }
//    }
}
