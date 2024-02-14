//
//  ShopDetail.swift
//  Honzapda
//
//  Created by 이희주 on 2024/02/11.
//

import Foundation


struct ShopDetail: Codable{
        
}

struct ShopDetailBody: Codable{
    
}


/*
{
    "isSuccess": true,
    "code": "COMMON200",
    "message": "성공입니다.",
    "result": {
        "shopId": 1,
        "shopName": "올댓마인드",
        "description": "실200평 대형공간대여 워크샵, 세미나, 파티, 학회, 레크리에이션, 플리마켓",
        "shopPhoneNumber": "02-6014-0361",
        "mainImage": "https://storage.googleapis.com/honzapda-bucket/58256d81-91ae-495d-8a45-5d49878f275e\n",
        "reviewCount": 5,
        "rating": 4.4,
        "address": "서울 영등포구",
        "address_spec": "문래로 55 203호",
        "stationDistance": "문래역에서 걸어서 8분",
        "openNow": false,
        "userLike": false,
        "inactiveDate": "2024-02-10T16:38:59.451271",
        "userHelpInfoDtoList": [
            {
                "user": {
                    "id": 4,
                    "name": "기승민",
                    "profileImage": "https://storage.googleapis.com/honzapda-bucket/image_my_profile.png",
                    "email": "ksm011212@gmail.com",
                    "signUpType": "LOCAL"
                },
                "visitDateTime": "2024-01-29T01:33:00",
                "like": {
                    "likeCount": 0,
                    "userLike": false
                },
                "congestion": "30%",
                "deskSize": "넓은",
                "outletCount": "넉넉한",
                "light": "밝은",
                "outletLocation": "책상 밑",
                "restroomLocation": "카운터 옆",
                "musicGenre": "잔잔한",
                "atmosphere": "아늑한",
                "userHelpInfId": 1,
                "createdAt": "2024-02-10T16:59:55.171192"
            },
            {
                "user": {
                    "id": 1,
                    "name": "김관주",
                    "profileImage": "https://storage.googleapis.com/honzapda-bucket/image_my_profile.png",
                    "email": "kkj6235@ajou.ac.kr",
                    "signUpType": "LOCAL"
                },
                "visitDateTime": "2024-01-31T14:21:00",
                "like": {
                    "likeCount": 0,
                    "userLike": false
                },
                "congestion": "10%",
                "deskSize": "적당한",
                "outletCount": "적당한",
                "light": "밝은",
                "outletLocation": "책상 밑",
                "restroomLocation": null,
                "musicGenre": "감성적인",
                "atmosphere": "조용한",
                "userHelpInfId": 2,
                "createdAt": "2024-02-10T17:03:35.730296"
            }
        ],
        "reviewList": [
            {
                "user": {
                    "id": 4,
                    "name": "기승민",
                    "profileImage": "https://storage.googleapis.com/honzapda-bucket/image_my_profile.png",
                    "email": "ksm011212@gmail.com",
                    "signUpType": "LOCAL"
                },
                "score": 5.0,
                "images": [
                    {
                        "imageId": 7,
                        "url": "https://storage.googleapis.com/honzapda-bucket/c3502f34-70f4-4af4-9e4b-7a8cff5f8682"
                    },
                    {
                        "imageId": 8,
                        "url": "https://storage.googleapis.com/honzapda-bucket/20249de8-8582-4f3a-9f0f-68ac5d410646"
                    }
                ],
                "body": "이번에 리뷰 이벤트로 케이크를 주셨는데, 너무 맛있었습니다",
                "visitedAt": "2024-02-20T19:19:08",
                "reviewId": 6,
                "shopId": 1,
                "createdAt": "2024-02-11T05:22:00.017981"
            },
            {
                "user": {
                    "id": 6,
                    "name": "이유진",
                    "profileImage": "https://storage.googleapis.com/honzapda-bucket/image_my_profile.png",
                    "email": "kynhun20@gachon.ac.kr",
                    "signUpType": "LOCAL"
                },
                "score": 4.0,
                "images": [
                    {
                        "imageId": 10,
                        "url": "https://storage.googleapis.com/honzapda-bucket/c7ceb056-68ae-43b3-b4e5-faa46b220421"
                    },
                    {
                        "imageId": 11,
                        "url": "https://storage.googleapis.com/honzapda-bucket/e923c594-1f0d-40bc-a248-bfdd4d2b19d9"
                    },
                    {
                        "imageId": 12,
                        "url": "https://storage.googleapis.com/honzapda-bucket/85e57324-5951-49b3-9455-d8ab1a986299"
                    },
                    {
                        "imageId": 13,
                        "url": "https://storage.googleapis.com/honzapda-bucket/22170fff-1ea4-420a-add7-1735e3de8cb0"
                    }
                ],
                "body": "요즘 읽는 책인데, 졸릴 때마다 여기 카페를 오고 있어요. 책 읽기 좋은 카페입니다~",
                "visitedAt": "2024-02-14T19:19:08",
                "reviewId": 8,
                "shopId": 1,
                "createdAt": "2024-02-11T14:27:57.800951"
            },
            {
                "user": {
                    "id": 5,
                    "name": "유연수",
                    "profileImage": "https://storage.googleapis.com/honzapda-bucket/image_my_profile.png",
                    "email": "cleanwater10@gachon.ac.kr",
                    "signUpType": "LOCAL"
                },
                "score": 5.0,
                "images": [
                    {
                        "imageId": 9,
                        "url": "https://storage.googleapis.com/honzapda-bucket/72bc668c-162c-426e-b356-e0bb8d86786c"
                    }
                ],
                "body": "회의 장소를 찾다가 떠올라서 재방문하였습니다. 공간이 넓고, 이야기하기 좋습니다.",
                "visitedAt": "2024-02-14T19:19:08",
                "reviewId": 7,
                "shopId": 1,
                "createdAt": "2024-02-11T05:27:38.943541"
            }
        ],
        "businessHours": [
            {
                "dayOfWeek": "MONDAY",
                "openHours": "09:00",
                "closeHours": "21:30",
                "isOpen": true
            },
            {
                "dayOfWeek": "TUESDAY",
                "openHours": "09:00",
                "closeHours": "21:30",
                "isOpen": true
            },
            {
                "dayOfWeek": "WEDNESDAY",
                "openHours": "09:00",
                "closeHours": "21:30",
                "isOpen": true
            },
            {
                "dayOfWeek": "THURSDAY",
                "openHours": "08:00",
                "closeHours": "21:00",
                "isOpen": true
            },
            {
                "dayOfWeek": "FRIDAY",
                "openHours": "08:00",
                "closeHours": "21:00",
                "isOpen": true
            },
            {
                "dayOfWeek": "SATURDAY",
                "openHours": null,
                "closeHours": null,
                "isOpen": false
            },
            {
                "dayOfWeek": "SUNDAY",
                "openHours": null,
                "closeHours": null,
                "isOpen": false
            }
        ],
        "latitude": 37.5204279064529,
        "longitude": 126.887847771379,
        "averageCongestions": [
            {
                "startTime": "18:00",
                "endTime": "20:00",
                "weekend": false
            },
            {
                "startTime": "14:00",
                "endTime": "16:00",
                "weekend": true
            }
        ],
        "dayCongestions": [
            {
                "dayOfWeek": "MONDAY",
                "congestionLevel": "COMFORTABLE"
            },
            {
                "dayOfWeek": "TUESDAY",
                "congestionLevel": "BUSY"
            },
            {
                "dayOfWeek": "WEDNESDAY",
                "congestionLevel": "COMFORTABLE"
            },
            {
                "dayOfWeek": "THURSDAY",
                "congestionLevel": "NORMAL"
            },
            {
                "dayOfWeek": "FRIDAY",
                "congestionLevel": "COMFORTABLE"
            },
            {
                "dayOfWeek": "SATURDAY",
                "congestionLevel": "BUSY"
            },
            {
                "dayOfWeek": "SUNDAY",
                "congestionLevel": "BUSY"
            }
        ],
        "totalSeatCount": 23,
        "cameraCount": 4,
        "wifiCount": 6
    }
}
*/
