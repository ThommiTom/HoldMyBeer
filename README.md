# Hold My Beer
This project contains the app 'Beer Punk' and has been developed with Xcode 14.3 and the iPhone 14 Pro Simulator (iOS 16.4).

The app supports users to brew their own beer. It enables them to browse through a beer catalog, mark beers for brewing and gives them brew instructions which also monitor the process and works as a to do list.

# Features
* uses PUNK API and URLSession to collect data from network
* allows browsing through beer catalog (Catalog Tab)
* allows search by parameter or by Beer Sommelier (recommends a beer on the food you'd like to eat)
* presentation of beer catalog in list and also shows beer details via new NavigationStack
* allows add a beer to brews by swiping beer item to the right
* shows beers which user wants to brew in Tab Brews
* allows to remove a beer from brews if user likes to by swiping brew item to the left
* shows brew details via new NavigationStack and shows current brew progress, next step, current step & last step
* shows the list of next steps or last stap via tab on NavigationLink
* allows to mark the current step as done with swipe gesture to the left
* once a brew is done, user is enabled to rate the beer with a 1 to 5 star rating and a comment
* uses FileManager to enable persistence in app
