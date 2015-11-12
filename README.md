# RWAuth-ios
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/RWAuth.svg)](https://img.shields.io/cocoapods/v/RWAuth.svg)

iOS lib written in Swift that takes care about all basic auth features provided by any RW backend.

## Features

- [x] Sign Up
- [x] Sign In
- [x] Sign Out
- [x] Request Recovery Code
- [x] Set New Password
- [x] Check Email
- [x] Manualy Tokens Refresh

## Requirements

- iOS 8.0+
- Xcode 7.0+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
To integrate RWAuth into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

pod 'RWAuth'
```

Then, run the following command:

```bash
$ pod install
```

## Usage

#### AuthPath

Standart Auth Path defined in AuthPath.swift. If you want to change defaults paths, scheme and host appropriately to yours Auth Paths, do next:
```swift
AuthPath.signUp = "/new/signup/path"
```

#### User
To access auth fuctionality use User's class methods. For example:

```swift
User.signInWithEmail(email, password: password) { (innerResult) -> Void in
	// do something with innerResult
}
```
#### Result

Most methods have closure argument of type `Result<Any, NSError>`. That type may contains parsed JSON as `[String: AnyObject]` or `NSError` with error discription. 