#
#  Be sure to run `pod spec lint HYCalendar.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.name         = "HYCalendar"
s.version      = "1.0.0"
s.summary      = "A Custom calenar library written in swift 3"
s.description  = "The HYCalendar is a completely customizable library that can be used in any iOS app."
s.homepage     = "https://github.com/harry-iOS/HYCalendar"


# ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.license      = "MIT"

# ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.author             = {"Harish Kumar Yadav" => "harry.ios.developer@outlook.com"  }

# ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

# s.platform     = :ios
# s.platform     = :ios, "9.0"


# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source       = { :git => "https://github.com/harry-iOS/HYCalendar.git", :tag => "1.0.0" }


# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source_files  = "HYCalendar", "HYCalendar/**/*.{h,swift}"


end
