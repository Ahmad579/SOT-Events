//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper


class UserResponse: Mappable , NSCoding {

    var success                              :       Int?
    var message                              :       String?
    var result                               :       UserResult?
    var aboutResult                          :       AboutInfo?


    required init?(map: Map){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
     
        success  =  aDecoder.decodeObject(forKey: "success") as? Int
        message  =  aDecoder.decodeObject(forKey: "message") as? String
        result  =   aDecoder.decodeObject(forKey: "result")  as? UserResult
        
    }
    
    func encode(with aCoder: NSCoder) {
        success  =  aCoder.decodeObject(forKey: "success") as? Int
        message  =  aCoder.decodeObject(forKey: "message") as? String
        result  =   aCoder.decodeObject(forKey: "result")  as? UserResult

    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        result    <- map["result"]
        aboutResult <- map["result"]
    }
}

class UserResult : Mappable , NSCoding {
    
    var userInfo: UserInformation?
    var event   : [EventObject]?
    var programSelect : [ProgramsObject]?
    var programTime     : [ProgramsTimeObject]?
    var participent     : [ParticipationUser]?
    var participentRole     : [ParticipationRole]?

    required init?(map: Map){
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        userInfo  =   aDecoder.decodeObject(forKey: "user")  as? UserInformation
        event  =   aDecoder.decodeObject(forKey: "events")  as? [EventObject]
        programSelect  =   aDecoder.decodeObject(forKey: "programs")  as? [ProgramsObject]
        programTime  =   aDecoder.decodeObject(forKey: "programs")  as? [ProgramsTimeObject]
        participent  =   aDecoder.decodeObject(forKey: "participants")  as? [ParticipationUser]
        participentRole  =   aDecoder.decodeObject(forKey: "participant_roles")  as? [ParticipationRole]

    }
    
    func encode(with aCoder: NSCoder) {
        
        userInfo  =   aCoder.decodeObject(forKey: "user")  as? UserInformation
        event  =   aCoder.decodeObject(forKey: "events")  as? [EventObject]
        programSelect  =   aCoder.decodeObject(forKey: "programs")  as? [ProgramsObject]
        programTime  =   aCoder.decodeObject(forKey: "programs")  as? [ProgramsTimeObject]
        participent  =   aCoder.decodeObject(forKey: "participants")  as? [ParticipationUser]
        participentRole  =   aCoder.decodeObject(forKey: "participant_roles")  as? [ParticipationRole]
        
    }
    
    func mapping(map: Map) {
        userInfo <- map["user"]
        event    <- map["events"]
        programSelect <- map["programs"]
        programTime <- map["programs"]
        participent <- map["participants"]
        participentRole <- map["participant_roles"]

    }
}

class AboutInfo  : Mappable {
    
    var name: String?
    var desig: String?
    var desc_1: String?
    var desc_2: String?
    var desc_3: String?
    var desc_4: String?
    var picture : String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        desig <- map["desig"]
        desc_1 <- map["desc_1"]
        desc_2 <- map["desc_2"]
        desc_3 <- map["desc_3"]
        desc_4 <- map["desc_4"]
        picture <- map["picture"]
        
        
    }
}

class UserInformation : Mappable , NSCoding {
    
    var user_id: String?
    var participant_id: String?
    var first_name: String?
    var email: String?
    var last_name: String?
    var date_of_birth : String?
    var phone : String?
    var image : String?
    var qrcode     : String?
    var gender     : String?
    var city_id : String?
    var location_id : String?
    var other_location : String?
    var is_associate : String?
    var association_id : String?
    var profile_update_status : String?

    required init?(map: Map){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        user_id  =   aDecoder.decodeObject(forKey: "user_id")  as? String
        participant_id  =   aDecoder.decodeObject(forKey: "participant_id")  as? String
        first_name  =   aDecoder.decodeObject(forKey: "first_name")  as? String
        email  =   aDecoder.decodeObject(forKey: "email")  as? String
        last_name  =   aDecoder.decodeObject(forKey: "last_name")  as? String
        date_of_birth  =   aDecoder.decodeObject(forKey: "date_of_birth")  as? String
        phone  =   aDecoder.decodeObject(forKey: "phone")  as? String
        image  =   aDecoder.decodeObject(forKey: "image")  as? String
        qrcode  =   aDecoder.decodeObject(forKey: "qrcode")  as? String
        gender  =   aDecoder.decodeObject(forKey: "gender")  as? String
        city_id  =   aDecoder.decodeObject(forKey: "city_id")  as? String
        location_id  =   aDecoder.decodeObject(forKey: "location_id")  as? String
        other_location  =   aDecoder.decodeObject(forKey: "other_location")  as? String
        is_associate  =   aDecoder.decodeObject(forKey: "is_associate")  as? String
        association_id  =   aDecoder.decodeObject(forKey: "association_id")  as? String
        profile_update_status  =   aDecoder.decodeObject(forKey: "profile_update_status")  as? String


    }
    
    func encode(with aCoder: NSCoder) {
        
        user_id  =   aCoder.decodeObject(forKey: "user_id")  as? String
        participant_id  =   aCoder.decodeObject(forKey: "participant_id")  as? String
        first_name  =   aCoder.decodeObject(forKey: "first_name")  as? String
        email  =   aCoder.decodeObject(forKey: "email")  as? String
        last_name  =   aCoder.decodeObject(forKey: "last_name")  as? String
        date_of_birth  =   aCoder.decodeObject(forKey: "date_of_birth")  as? String
        phone  =   aCoder.decodeObject(forKey: "phone")  as? String
        image  =   aCoder.decodeObject(forKey: "image")  as? String
        qrcode  =   aCoder.decodeObject(forKey: "qrcode")  as? String
        gender  =   aCoder.decodeObject(forKey: "gender")  as? String
        city_id  =   aCoder.decodeObject(forKey: "city_id")  as? String
        location_id  =   aCoder.decodeObject(forKey: "location_id")  as? String
        other_location  =   aCoder.decodeObject(forKey: "other_location")  as? String
        is_associate  =   aCoder.decodeObject(forKey: "is_associate")  as? String
        association_id  =   aCoder.decodeObject(forKey: "association_id")  as? String
        profile_update_status  =   aCoder.decodeObject(forKey: "profile_update_status")  as? String

    }
    
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        participant_id <- map["participant_id"]
        first_name <- map["first_name"]
        email <- map["email"]
        last_name <- map["last_name"]
        date_of_birth <- map["date_of_birth"]
        phone <- map["phone"]
        image <- map["image"]
        qrcode <- map["qrcode"]
        gender <- map["gender"]
        city_id <- map["city_id"]
        location_id <- map["location_id"]
        other_location <- map["other_location"]
        is_associate <- map["is_associate"]
        association_id <- map["association_id"]
        profile_update_status <- map["profile_update_status"]

        
    }
}


class EventObject : Mappable {
    
    var event_id: String?
//    var eventids: Int?

    var event_title: String?
    var event_desc: String?
    var active: String?
    var start_date: String?
    var end_date: String?
    var display_date: String?
    var evaluation_exists: String?
    var evaluation_active: String?
    var evaluation_submitted: String?
    var session_tagline: String?
    var speaker_tagline: String?
    var fullsteam_desc: String?
    var location      : [LocationObject]?
    var eventDate     : [EventDateObject]?
    var activityType  : [EventActivityType]?
    var eventDimention : [EventDimensions]?
    var eventVenue     : [EventVenue]?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_id <- map["event_id"]
        event_title <- map["event_title"]
        event_desc <- map["event_desc"]
        active <- map["active"]
        start_date <- map["start_date"]
        end_date <- map["end_date"]
        display_date <- map["display_date"]
        evaluation_exists <- map["evaluation_exists"]
        evaluation_active <- map["evaluation_active"]
        evaluation_submitted <- map["evaluation_submitted"]
        session_tagline <- map["session_tagline"]
        speaker_tagline <- map["speaker_tagline"]
        fullsteam_desc <- map["fullsteam_desc"]
        location <- map["locations"]
        eventDate <- map["event_dates"]
        activityType <- map["activity_types"]
        eventDimention <- map["dimensions"]
        eventVenue <- map["venues"]
        
    }
}

class LocationObject : Mappable {
    
    var location_id: String?
    var location_name: String?
    var city_id: String?
    var city_name: String?
    var status: String?
    var lat: String?
    var long: String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        location_id <- map["location_id"]
        location_name <- map["location_name"]
        city_id <- map["city_id"]
        city_name <- map["city_name"]
        status <- map["status"]
        lat <- map["lat"]
        long <- map["long"]

        
    }
}



class EventDateObject : Mappable {
    
    var event_display_date: String?
    var event_date: String?
    var event_day: Int?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_display_date <- map["event_display_date"]
        event_date <- map["event_date"]
        event_day <- map["event_day"]
        
    }
}

class EventActivityType : Mappable {
    
    var activity_desc: String?
    var activity_type_id: String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        activity_desc <- map["activity_desc"]
        activity_type_id <- map["activity_type_id"]
        
    }
}

class EventDimensions : Mappable {
    
    var short_name: String?
    var theme_desc: String?
    var theme_id: String?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        short_name <- map["short_name"]
        theme_desc <- map["theme_desc"]
        theme_id <- map["theme_id"]

        
    }
}

class EventVenue : Mappable {
    
    var location_id: String?
    var sort_order: String?
    var venue_id: String?
    var venue_title: String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        location_id <- map["location_id"]
        sort_order <- map["sort_order"]
        venue_id <- map["venue_id"]
        venue_title <- map["venue_title"]

        
        
    }
}


class ProgramsObject : Mappable {
    
    var event_id: String?
    var schedule_id: String?
    var poll_exists: String?
    var poll_active: String?
    var poll_submitted: String?
    var evaluation_exists: String?
    var evaluation_active: String?
    var evaluation_submitted   : String?
    var attendance   : String?
    var activity_type_id   : String?
    var activity_desc   : String?
    var activity_id   : String?
    var activity_title   : String?
    var activity_date   : String?
    var abstract   : String?
    var start_time   : String?
    var end_time   : String?
    var display_date   : String?
    var location_id   : String?
    var theme_id   : String?
    var theme_desc : String?
    var venue_id   : String?
    var venue_title   : String?
    var participant   : [ParticipationObject]?


    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_id <- map["event_id"]
        schedule_id <- map["schedule_id"]
        poll_exists <- map["poll_exists"]
        poll_active <- map["poll_active"]
        poll_submitted <- map["poll_submitted"]
        evaluation_exists <- map["evaluation_exists"]
        evaluation_active <- map["evaluation_active"]
        attendance <- map["attendance"]
        activity_type_id <- map["activity_type_id"]
        activity_desc <- map["activity_desc"]
        activity_id <- map["activity_id"]
        activity_title <- map["activity_title"]
        activity_date <- map["activity_date"]
        abstract <- map["abstract"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        display_date <- map["display_date"]
        location_id <- map["location_id"]
        theme_id <- map["theme_id"]
        venue_id <- map["venue_id"]
        venue_title <- map["venue_title"]
        participant <- map["participants"]
        theme_desc  <- map["theme_desc"]

        
    }
}

class ProgramsTimeObject : Mappable {
    
    var event_id: String?
    var schedule_id: String?
    var activity_type_id   : String?
    var activity_desc   : String?
    var activity_id   : String?
    var activity_title   : String?
    var activity_date   : String?
    var abstract   : String?
    var start_time   : String?
    var end_time   : String?
    var display_date   : String?
    var location_id   : String?
    var theme_id   : String?
    var venue_id   : String?
    var venue_title   : String?
    var participant   : [ParticipationObject]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_id <- map["event_id"]
        schedule_id <- map["schedule_id"]
        activity_type_id <- map["activity_type_id"]
        activity_desc <- map["activity_desc"]
        activity_id <- map["activity_id"]
        activity_title <- map["activity_title"]
        activity_date <- map["activity_date"]
        abstract <- map["abstract"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        display_date <- map["display_date"]
        location_id <- map["location_id"]
        theme_id <- map["theme_id"]
        venue_id <- map["venue_id"]
        venue_title <- map["venue_title"]
        participant <- map["participants"]
        
    }
}

class ParticipationObject : Mappable {
    
    var participant_id: String?
    var participant_name: String?
    var participant_photo: String?
    var designation: String?
    var experties: String?
    var profile_desc: String?
    var gender: String?
    var linkedin_url: String?
    var twitter_url: String?
    var role_id: String?
    var role_desc: String?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        participant_id <- map["participant_id"]
        participant_name <- map["participant_name"]
        participant_photo <- map["participant_photo"]
        role_id <- map["role_id"]
        designation <- map["designation"]
        experties <- map["experties"]
        profile_desc <- map["profile_desc"]
        gender <- map["gender"]
        linkedin_url <- map["linkedin_url"]
        twitter_url <- map["twitter_url"]

        
        
        
    }
}

class ParticipationUser : Mappable {
    
    var event_id: String?
    var participant_id: String?
    var user_id: String?
    var title: String?
    var first_name: String?
    var middle_name: String?
    var last_name: String?
    var participant_name: String?
    var gender: String?
    var role_id: String?
    var role_desc: String?
    var participant_photo: String?
    var featured: String?
    var designation: String?
    var sub_designation: String?
    var experties: String?
    var profile_desc: String?
    var profile_tags: String?
    var twitter_url: String?
     var linkedin_url: String?
   
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        event_id <- map["event_id"]
        participant_id <- map["participant_id"]
        user_id <- map["user_id"]
        title <- map["title"]
        first_name <- map["first_name"]
        middle_name <- map["middle_name"]
        last_name <- map["last_name"]
        participant_name <- map["participant_name"]
        gender <- map["gender"]
        role_id <- map["role_id"]
        role_desc <- map["role_desc"]
        participant_photo <- map["participant_photo"]
        featured <- map["featured"]
        designation <- map["designation"]
        sub_designation <- map["sub_designation"]
        experties <- map["experties"]
        profile_desc <- map["profile_desc"]
        twitter_url <- map["twitter_url"]
        linkedin_url <- map["linkedin_url"]

        
        
        
    }
}


class ParticipationRole : Mappable {
    
    var role_id: String?
    var role_desc: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        role_id <- map["role_id"]
        role_desc <- map["role_desc"]
        
    }
}

class ClubDetailObject : Mappable {
    
    var name: String?
    var image: String?
    var club_type: String?
    var longitude: String?
    var latitude: String?
    var open_time: String?
    var close_time: String?
    var clunInfo  : ClubInfo?
    var clubTeam  : [ClubTeam]?
    var clubPhoto : [ClubPhoto]?
    var clubVideo : [ClubVideos]?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        club_type <- map["club_type"]
        image <- map["image"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        open_time <- map["open_time"]
        close_time <- map["close_time"]
        clunInfo <- map["info"]
        clubTeam <- map["team"]
        clubPhoto <- map["bar_images"]
        clubVideo <- map["bar_videos"]

        
    }
}

class ClubInfo : Mappable {
    
    var information: String?
    var contact_number: String?
    var website: String?
    var email: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        information <- map["information"]
        contact_number <- map["contact_number"]
        email <- map["email"]
        website <- map["website"]
        
        
        
    }
}

class ClubTeam : Mappable {
    
    var title: String?
    var designation: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        designation <- map["designation"]
        
        
        
    }
}

class ClubPhoto : Mappable {
    
    var image: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        
        
        
    }
}

class ClubVideos : Mappable {
    
    var image: String?
    var thumbNail : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["video"]
        thumbNail <- map["thumbnail"]
        
        
        
    }
}

class ClubSocial : Mappable {
    
    var twitter: String?
    var facebook: String?
    var website: String?
    var instagram: String?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        twitter <- map["twitter"]
        facebook <- map["facebook"]
        website <- map["website"]
        instagram <- map["instagram"]
        
        
        
    }
}




class DealData : Mappable {
    
    var menuOfRestaurantOfDeal : RestaurantMenu?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        menuOfRestaurantOfDeal <- map["menu"]
    }
}



class ReceipeObject : Mappable {
    
    var id: Int?
    var user_id: String?
    var title: String?
    var instructions: String?
    var ingredients : Bool?
    var time_to_cook : Bool?
    var image_url : String?
    var tags     : String?
    var user                : UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        title <- map["title"]
        instructions <- map["instructions"]
        ingredients <- map["ingredients"]
        time_to_cook <- map["time_to_cook"]
        image_url <- map["image_url"]
        user <- map["user"]
        tags <- map["tags"]
        
        
        
        
    }
}

class UserOrder : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var user_id: String?
    var order_status: String?
    var payment_date : String?
    var order_date : String?
    var sub_total : String?
    var coupon_code     : String?
    var discount     : String?
    var delivery_charges     : String?
    var tax     : String?
    var total_payment     : String?
    var address     : String?
    var reservation     : String?
    var totalperson     : String?

    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id <- map["resturant_id"]
        user_id <- map["user_id"]
        order_status <- map["order_status"]
        payment_date <- map["payment_date"]
        order_date <- map["order_date"]
        sub_total <- map["sub_total"]
        coupon_code <- map["coupon_code"]
        discount <- map["discount"]
        tax <- map["tax"]
        total_payment <- map["total_payment"]
        address <- map["address"]
        reservation <- map["reservation"]
        totalperson <- map["totalperson"]

        
        
        
        
    }
}

class OrderListObject : Mappable {
    
    var id: Int?
    var coupon_code: String?
    var order_date: String?
    var order_status: String?
    var payment_date : Bool?
    var reservation : Bool?
    var resturant_id : String?
    var total_payment     : String?
    var user_id     : String?
    var restaurent                       :  AllRestaurantList?
    var userInfo                         :  UserInformation?
    var items                            :  [RestaurantMenu]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        coupon_code <- map["coupon_code"]
        order_date <- map["order_date"]
        order_status <- map["order_status"]
        payment_date <- map["payment_date"]
        reservation <- map["reservation"]
        resturant_id <- map["resturant_id"]
        total_payment <- map["total_payment"]
        user_id <- map["user_id"]
        restaurent <- map["resturant"]
        items <- map["items"]


        
        
        
    }
}

class DealList : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var deal_name: String?
    var deal_type: String?
    var deal_description : String?
    var deal_price : String?
    var image : String?
    
    var restaurent                       :   AllRestaurantList?
    var userInfo                         :   UserInformation?
    var dealItemList                     :   [DealItem]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id <- map["resturant_id"]
        deal_name <- map["deal_name"]
        deal_type <- map["deal_type"]
        deal_description <- map["deal_description"]
        deal_price <- map["deal_price"]
        image <- map["image"]
        restaurent <- map["resturant"]
        userInfo <- map["customer"]
        dealItemList <- map["deal_items"]
    }
}

class DealItem : Mappable {
    
    var id: Int?
    var deal_id: String?
    var menu_item_id: String?
    var quantity: String?
    var menu    : RestaurantMenu?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        deal_id <- map["deal_id"]
        menu_item_id <- map["menu_item_id"]
        quantity <- map["quantity"]
        menu <- map["menu"]
    }
}


class AllRestaurantList : Mappable {
    
    
    var id: Int?
    var category_id: String?
    var name: String?
    var phone_no: String?
    var location: String?
    var latitude : String?
    var longitude : String?
    var image_url : String?
    var do_delivery     : Int?
    var about     : Int?
    var opening_time : String?
    var closing_time : String?

    var distance : String?
    var timings : String?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        category_id <- map["category_id"]
        name    <- map["name"]
        phone_no    <- map["phone_no"]
        location    <- map["location"]
        latitude    <- map["latitude"]
        longitude    <- map["longitude"]
        image_url    <- map["image_url"]
        do_delivery    <- map["do_delivery"]
        about    <- map["about"]
        opening_time    <- map["opening_time"]
        closing_time    <- map["closing_time"]
        distance    <- map["distance"]
        timings    <- map["timings"]


    }
}

class RestaurantDetailObject : Mappable {
    
    var id: Int?
    var category_id: String?
    var resturant_id: String?
    var slug: String?
    var category_name: String?
    var restaurentInfo : AllRestaurantList?
    var menuOfRestaurant : [RestaurantMenu]?
    var menu             : RestaurantMenu?

    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        category_id <- map["category_id"]
        resturant_id    <- map["resturant_id"]
        slug    <- map["slug"]
        category_name <- map["category_name"]
        restaurentInfo <- map["resturant"]
        menuOfRestaurant <- map["menu"]
        menu  <- map["menu"]
        

    }
}


class MenuCategory : Mappable {
    
    var id: Int?
    var resturant_id: String?
    var slug: String?
    var category_name: String?
    var menuOfRestaurant : [RestaurantMenu]?
    
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        resturant_id    <- map["resturant_id"]
        slug    <- map["slug"]
        category_name <- map["category_name"]
        menuOfRestaurant <- map["menu"]
        
        
    }
}


class RestaurantMenu : Mappable {
    
    var id: Int?
    var menu_category_id: String?
    var menu_item_id    : String?
    var item_name: String?
    var description: String?
    var available: String?
    var price: String?
    var order_id : String?
    var quantity : String?
    var menuItem : MenuItem?
    var menuCategory : RestaurantDetailObject?


    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        menu_category_id <- map["menu_category_id"]
        menu_item_id     <- map["menu_item_id"]
        item_name <- map["item_name"]
        description <- map["description"]
        available <- map["available"]
        price <- map["price"]
        order_id <- map["order_id"]
        quantity <- map["quantity"]
        menuCategory <- map["menu_category"]
        menuItem <- map["menu_item"]

    }
}


class MenuItem : Mappable {
    
    var id                  :       Int?
    var menu_category_id              :       String?
    var item_name              :       String?
    var description              :       String?

    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        menu_category_id <- map["menu_category_id"]
        item_name <- map["item_name"]
        description <- map["description"]

    }
}



class UserProfileObject : Mappable {
    
    var image                  :       String?
    var imageName              :       String?
    
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        imageName <- map["imagename"]
    }
}












class UserData : Mappable {
    
    var user: UserInformation?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        
    }
    
}





