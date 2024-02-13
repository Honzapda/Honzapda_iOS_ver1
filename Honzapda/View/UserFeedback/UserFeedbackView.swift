//
//  UserFeedbackView.swift
//  Honzapda
//
//  Created by 이재용 on 2/11/24.
//
// how to work
/*
 1. 구조
 [네비바]
 [고정 뷰, 유저 도움 정보 (var totalElement) 개 , 정보제공하기 버튼, 설명]
 [스크롤 뷰 of (userFeedbackCellView), CreateUFCellView()함수로 생성 ] - 무한스크롤
 2. 동작
 - 화면 진입
    UFBGetapi 작동,  ?? 그러면 shopid는 어떻게 알것인가?
 - 해당 api에서 받아온 값으로 (var totalElement)를 채움
 - createUFCellView로 UFBcellView 생성, 페이지만큼 생성
 - 해당 셀을 Vstack, 스크롤 뷰 내에 생성, 
 */
import Foundation
import SwiftUI
