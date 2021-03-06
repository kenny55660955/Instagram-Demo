//
//  Model.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/29.
//

import Foundation

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let profilePhoto: URL
    let bitrhDate: Date
    let gender: Gender
    let count: UserCount
    let joinDate: Date
}
enum Gender {
    case male, female, other
}
enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

// For user post
struct UserPhotoPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String?
    let likeCount: Int
    let comment: [PostComment]
    let createdData: Date
    let taggedUsers: [String]
    let ower: User
}
struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLike]
}
