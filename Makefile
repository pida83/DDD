	
project:
	tuist clean
	tuist fetch
	tuist generate --no-open && pod install  &&  open iosYeoboya.xcworkspace
c:
	tuist fetch
	tuist generate 
g:
	tuist generate --no-open
e:
	tuist edit
open: 
	tuist generate --no-open && pod install &&  open iosYeoboya.xcworkspace

asset:
	tuist generate --no-open
	pod install
