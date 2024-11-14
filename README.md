### Steps to Run the App
1. Clone repository to local machine
2. Make sure SPM fetches the SDWebImage package
3. Run the app on your physical device or simulator

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I decided to heavily focus my efforts on the app's UI and testability. I believe that for consumer apps, the user is always the priority. Having an intuitive UI makes using the app easy and fun. As for testability, ensuring important aspects of the app can be effectively tested reduces potential bugs. Having as few bugs as possible is also very important to ensuring a high quality user experience.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent around 5 hours working on the project. I would say I spent the largest amount of time creating an intuitive UI that has all the features a user would expect out of a recipe app. After that, I spent the second most time on building my network layer and view model to be highly testable. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
There were a couple of trade-offs I made while developing this project. The first one was using the external library SDWebImage. External libraries can be an issue because you don't have full control over the library. If it has bugs or stops receiving updates, there's not much you can do. However, I believed that SDWebImage could provide better image caching than I could considering the time constraints. Additionally, SDWebImage is a well-known and widely used library that has been supported for many years.

The second trade-off I made is code complexity. In order to make the app as testable as possible, I created a couple of protocols for my network layer and view model. In my opinion, these protocols can make it little bit harder to understand what's happening in the code. However, I think this trade-off is worth it because it allows my app's view model and network layer to be fully tested in an easy way.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I think the weakest part of the project is its inability to support all screen sizes. Because of time constraints, I was unable to test my app on iOS devices like the iPad or smaller screen sizes like the iPhone SE. While the app could run on all of these devices, I don't think the UI would adjust as nicely as I would like. This is something that's especially important for a recipe app because I would imagine quite a few people use iPads to look at recipes while cooking.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
- SDWebImage for SwiftUI

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
